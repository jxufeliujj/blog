package blog

import (
	"github.com/astaxie/beego"
	"github.com/jxufeliujj/blog/models"
	"strings"
)

type baseController struct {
	beego.Controller
	moduleName     string
	controllerName string
	actionName     string
	options        map[string]string
}

func (this *baseController) Prepare() {
	controllerName, actionName := this.GetControllerAndAction()
	this.moduleName = "blog"
	this.controllerName = strings.ToLower(controllerName[0 : len(controllerName)-10])
	this.actionName = strings.ToLower(actionName)
	this.options = models.GetOptions()
	this.Data["options"] = this.options
}

func (this *baseController) display(tpl ...string) {
	var theme string
	if v, ok := this.options["theme"]; ok && v != "" {
		theme = v
	} else {
		theme = "default"
	}
	this.Layout = theme + "/layout.html"
	this.Data["root"] = "/" + beego.ViewsPath + "/" + theme + "/"
	this.TplNames = theme + "/" + tpl[0] + ".html"

	this.LayoutSections = make(map[string]string)
	this.LayoutSections["head"] = theme + "/head.html"
	this.LayoutSections["foot"] = theme + "/foot.html"
	this.LayoutSections["banner"] = theme + "/banner.html"
	this.LayoutSections["photo"] = theme + "/photo.html"
	this.LayoutSections["right"] = theme + "/right.html"

	var section []string
	l := len(tpl)
	for i := 1; i < l; i++ {
		section = strings.Split(tpl[i], "-")
		if len(section) == 2 {
			this.LayoutSections[section[0]] = theme + "/" + section[1] + ".html"
		} else {
			this.LayoutSections[section[0]] = ""
		}
	}
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
