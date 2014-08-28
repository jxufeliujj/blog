package blog

import (
	"github.com/astaxie/beego"
	"github.com/jxufeliujj/blog/models"
	"strings"
)

type baseController struct {
	beego.Controller
	options map[string]string
	right   string
}

func (this *baseController) Prepare() {
	this.options = models.GetOptions()
	this.right = "right.html"
	this.Data["options"] = this.options
}

func (this *baseController) display(tpl string) {
	theme := "default"
	if v, ok := this.options["theme"]; ok && v != "" {
		theme = v
	}

	this.Layout = theme + "/layout.html"
	this.Data["root"] = "/" + beego.ViewsPath + "/" + theme + "/"
	this.TplNames = theme + "/" + tpl + ".html"

	this.LayoutSections = make(map[string]string)
	this.LayoutSections["head"] = theme + "/head.html"

	if tpl == "index" {
		this.LayoutSections["banner"] = theme + "/banner.html"
		this.LayoutSections["photo"] = theme + "/photo.html"
	}
	if this.right != "" {
		this.LayoutSections["right"] = theme + "/" + this.right
	}
	this.LayoutSections["foot"] = theme + "/foot.html"
}

func (this *baseController) getOption(name string) string {
	if v, ok := this.options[name]; ok {
		return v
	} else {
		return ""
	}
}

func (this *baseController) setHeadMetas(params ...string) {
	title_buf := make([]string, 0, 3)
	if len(params) == 0 && this.getOption("subtitle") != "" {
		title_buf = append(title_buf, this.getOption("subtitle"))
	}
	if len(params) > 0 {
		title_buf = append(title_buf, params[0])
	}
	title_buf = append(title_buf, this.getOption("sitename"))
	this.Data["title"] = strings.Join(title_buf, " - ")

	if len(params) > 1 {
		this.Data["keywords"] = params[1]
	} else {
		this.Data["keywords"] = this.getOption("keywords")
	}

	if len(params) > 2 {
		this.Data["description"] = params[2]
	} else {
		this.Data["description"] = this.getOption("description")
	}
}
