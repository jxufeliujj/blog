package admin

import (
	"github.com/jxufeliujj/blog/models"
	"strings"
	"time"
)

type AlbumController struct {
	baseController
}

//说说列表
func (this *AlbumController) List() {
	var page int64
	var pagesize int64 = 10
	var list []*models.Album
	var album models.Album

	if page, _ = this.GetInt("page"); page < 1 {
		page = 1
	}
	offset := (page - 1) * pagesize

	count, _ := album.Query().Count()
	if count > 0 {
		album.Query().OrderBy("-id").Limit(pagesize, offset).All(&list)
	}

	this.Data["list"] = list
	this.Data["pagebar"] = models.NewPager(page, count, pagesize, "/admin/album/list?page=%d").ToString()
	this.display()
}

//发表说说
func (this *AlbumController) Add() {
	if this.Ctx.Request.Method == "POST" {
		content := strings.TrimSpace(this.GetString("content"))
		cover := strings.TrimSpace(this.GetString("cover"))

		var album models.Album
		album.Name = content
		album.Cover = cover
		album.Posttime = time.Now()
		if err := album.Insert(); err != nil {
			this.showmsg(err.Error())
		}
		this.Redirect("/admin/album/list", 302)

	}
	this.display()
}

//删除说说
func (this *AlbumController) Delete() {
	id, _ := this.GetInt("id")
	album := models.Album{Id: id}
	if album.Read() == nil {
		album.Delete()
	}
	this.Redirect("/admin/album/list", 302)
}
