---
title: PerAuthorize注解的作用作授权时的使用方法
date: 2020-08-14 10:14:07
tags:
- Spring
---

@PerAuthorizr 这个注解我相信很多不使用SpringSecurity的小伙伴都不是很了解。
使用他的初衷是最近需要做一个对授权的客户做判断，让他买了哪些模块的代码才能使用哪些模块的代码，需要进行一波模块过滤。
@PreAuthorize是可以用来控制一个方法或类是否能够被调用的，通俗一点就是看看你有没有权利用被注解的东西。怎么用呢？直接上代码吧。

```java
    /**
     * 获取部门列表
     */
    @PreAuthorize("@ac.hasPermi('dept:list')")
    @GetMapping("/list")
    public AjaxResult list(SysDept dept) {
        List<SysDept> depts = deptService.selectDeptList(dept);
        return AjaxResult.success(depts);
    }

```

这里@PreAuthorize("@ac.hasPermi(‘dept:list’)")是调用别名为as类的hasPermi方法。

```
/**
* 根据授权文件获取接口权限
*/
public boolean hasPermi(String permission) {
	log.debug(" 当前模块：{} 当前权限：{} ", permission, AuthorizationConfig.isAccess() && authorizationConfig.getMk().indexOf(permission) >= 0);
    return AuthorizationConfig.isAccess() && authorizationConfig.getMk().indexOf(permission) >= 0;
}
```

我这里就简单写一下供大家参考。
判断结果返回true则正常调用接口，false则接口返回403。

加在类头上依然有效，上代码：

```java
/**
 * 部门信息
 */
@RestController
@PreAuthorize("@ac.hasPermi('mk')")
@RequestMapping("/system/dept")
public class SysDeptController extends BaseController {
    
    @Autowired
    private ISysDeptService deptService;
    ...
}

```

放了类头上会在每次调用改类方法的时候都会进行一次判断。

这样授权给用户的功能实现了，但是一个用户登录过之后，每次请求接口都要进行一次权限判断，这显然不合理，所以我想加上一个给每个用户本次登录判断完权限有之后加一个标识。这个写好了就更新~

