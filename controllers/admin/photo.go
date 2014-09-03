package admin

import (
	"github.com/jxufeliujj/blog/models"
	"strings"
	"time"
)

type PhotoController struct {
	baseController
}

//照片列表
func (this *PhotoController) List() {
	var albumid int64
	var list []*models.Photo
	var photo models.Photo

	if albumid, _ = this.GetInt("albumid"); albumid < 1 {
		albumid = 1
	}
	count, _ := photo.Query().Count()
	if count > 0 {
		photo.Query().OrderBy("-id").Filter("albumid", albumid).All(&list)
	}
	this.display()
}

//上传照片
func (this *PhotoController) Add() {
	if this.Ctx.Request.Method == "POST" {
		content := strings.TrimSpace(this.GetString("content"))
		cover := strings.TrimSpace(this.GetString("cover"))

		var photo models.Photo
		photo.Name = content
		photo.Cover = cover
		photo.Posttime = time.Now()
		if err := photo.Insert(); err != nil {
			this.showmsg(err.Error())
		}
		this.Redirect("/admin/photo/list", 302)

	}
	this.display()
}

//删除照片
func (this *PhotoController) Delete() {
	id, _ := this.GetInt("id")
	photo := models.Photo{Id: id}
	if photo.Read() == nil {
		photo.Delete()
	}
	this.Redirect("/admin/photo/list", 302)
}
