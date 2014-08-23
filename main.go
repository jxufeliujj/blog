package main

import (
	"github.com/astaxie/beego"
	_ "github.com/jxufeliujj/blog/models"
	_ "github.com/jxufeliujj/blog/routers"
)
//中文
func main() {
	beego.Run()
}
