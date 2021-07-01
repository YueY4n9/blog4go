包中引用多个其他功能同级目录的包导致的重命名规则

>   功能模块名简写+当前目录层级名简写，全部字母小写；
>
>   当不同功能模块简写重复时，后添加的功能模块包使用易懂的简写代替；

```go
import{
    uc "powerlaw.ai/meflow/controller/internal/app/utils/consts/user" // uc表示userconsts
}
```

包中引用系统级别包和自定义包导致的重命名规则

>   系统级别包使用前缀`sys`+包名或缩写
>
>   Golang扩展包使用`go`或扩展包前缀+包名或缩写
>
>   用户自定义包使用原名或缩写，全部字母小写；

```go
import{
    sysctx 	"context"
    
   	gouuid "github.com/satori/go.uuid"
    gomail "gopkg.in/mail.v2"
    
    context "powerlaw.ai/meflow/controller/internal/app/domain/contract/entity"
}
```

包中引用工具包，可以直接重定义命名

>   引用工具包时，即使没有重名包的情况下，对工具包直接重命名，全部字母小写；

```go
import{
    httputils "powerlaw.ai/meflow/controller/internal/app/utils/http" 
}
```

>   结构体中引用到多个其他其他功能同级目录的类型时，参数名使用功能模块名+目录层级名，小驼峰命名（包名中包含多词时以功能为最小单位）
>
>   引用到系统级别包或自定义系统级功能包时，
>
>   当`单词长度≤8`时，参数名可以使用单词全拼；
>
>   当`单词长度＞8`时，参数名使用短命名形式；

```go
type service struct {
    ctx 				*context.AppContext	// AppContext就简写成ctx
    workflowDomain 		workflow.Domain		// workflow长度适宜，使用全拼，且不允许写成workFlow
    bcDomain 			bcd.Domain 			// businesscategory过长，就简写成了bc
}
```