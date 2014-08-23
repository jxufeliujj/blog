package main

import (
	"github.com/astaxie/beego"
	_ "github.com/lisijie/goblog/models"
	_ "github.com/lisijie/goblog/routers"
)

func main() {
	beego.Run()
}
