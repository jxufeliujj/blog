package models

import (
	"bytes"
	"fmt"
	"math"
)

type Pager struct {
	Page     int64
	Totalnum int64
	Pagesize int64
	urlpath  string
	pre      string
	ext      string
}

func NewPager(page, totalnum, pagesize int64, arg ...string) *Pager {
	p := new(Pager)
	p.Page = page
	p.Totalnum = totalnum
	p.Pagesize = pagesize
	p.pre = arg[0]
	if len(arg) > 1 {
		p.ext = arg[1]
	}
	if len(arg) > 2 {
		p.urlpath = arg[2]
	}
	return p
}

func (this *Pager) url(page int64) string {
	if this.urlpath != "" {
		if this.ext != "" {
			return fmt.Sprintf("/%s/%s%d.%s", this.urlpath, this.pre, page, this.ext)
		} else {
			return fmt.Sprintf("/%s/?%s=%d", this.urlpath, this.pre, page)
		}

	} else {

		if this.ext != "" {
			return fmt.Sprintf("/%s%d.%s", this.pre, page, this.ext)
		} else {
			return fmt.Sprintf("/?%s=%d", this.pre, page)
		}
	}
}

// <div class="page">
// <a title="Total record"><b>105</b></a>
// <a href="/news/index.html"><<</a>
// <a href="/news/index.html"><</a>
// <a href="/news/index.html">1</a>
// <b>2</b>
// <a href="/news/index_3.html">3</a>
// <a href="/news/index_4.html">4</a>
// <a href="/news/index_5.html">5</a>
// <a href="/news/index_3.html">></a>
// <a href="/news/index_5.html">>></a>
// </div>

func (this *Pager) ToString() string {
	if this.Totalnum <= this.Pagesize {
		return ""
	}

	var buf bytes.Buffer
	var from, to, linknum, offset, totalpage int64

	offset = 5
	linknum = 10

	totalpage = int64(math.Ceil(float64(this.Totalnum) / float64(this.Pagesize)))

	if totalpage < linknum {
		from = 1
		to = totalpage
	} else {
		from = this.Page - offset
		to = from + linknum
		if from < 1 {
			from = 1
			to = from + linknum - 1
		} else if to > totalpage {
			to = totalpage
			from = totalpage - linknum + 1
		}
	}

	buf.WriteString("<div class=\"page\">")
	buf.WriteString(fmt.Sprintf("<a title=\"Total record\"><b>%d</b></a>", 107))
	if this.Page > 1 {
		buf.WriteString(fmt.Sprintf("<a href=\"%s\">&laquo;</a>", this.url(this.Page-1)))
	} else {
		buf.WriteString("<b>&laquo;</b>")
	}

	if this.Page > linknum {
		buf.WriteString(fmt.Sprintf("<a href=\"%s\">1</a>", this.url(1)))
	}

	for i := from; i <= to; i++ {
		if i == this.Page {
			buf.WriteString(fmt.Sprintf("<b>%d</b>", i))
		} else {
			buf.WriteString(fmt.Sprintf("<a href=\"%s\">%d</a>", this.url(i), i))
		}
	}

	if totalpage > to {
		buf.WriteString(fmt.Sprintf("<a href=\"%s\">%d</a>", this.url(totalpage), totalpage))
	}

	if this.Page < totalpage {
		buf.WriteString(fmt.Sprintf("<a href=\"%s\">&raquo;</a>", this.url(this.Page+1)))
	} else {
		buf.WriteString(fmt.Sprintf("<b>&raquo;</b>"))
	}
	buf.WriteString("</div>")

	return buf.String()
}
