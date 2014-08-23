package main

import (
	"github.com/astaxie/beego"
	_ "github.com/jxufeliujj/blog/models"
	_ "github.com/jxufeliujj/blog/routers"
)

func main() {
	beego.Run()
}
