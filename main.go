package main

import (
	"github.com/astaxie/beego"
	_ "github.com/jxufeliujj/blog/models"
	_ "github.com/jxufeliujj/blog/routers"
)
//去掉中文
func main() {
	beego.Run()
}
