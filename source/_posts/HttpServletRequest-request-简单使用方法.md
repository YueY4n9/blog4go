---
title: HttpServletRequest request 简单使用方法
date: 2020-08-18 11:07:33
tags:
---

<!--more-->

### HttpServletRequest 详解

HttpServletRequest对象代表客户端的请求，当客户端通过HTTP协议访问服务器时，HTTP请求头中的所有信息都封装在这个对象中，通过这个对象提供的方法，可以获得客户端请求的所有信息。

常用到的几个方法：

```java
request.getRequestURL() 返回全路径
request.getRequestURI() 返回除去host（域名或者ip）部分的路径
request.getContextPath() 返回工程名部分，如果工程映射为/，此处返回则为空
request.getServletPath() 返回除去host和工程名部分的路径
1234
```

例如获取验证码的情况：

```java
request.getRequestURL() is : http://localhost:8080/captchaImage
request.getRequestURI() is : /captchaImage
request.getContextPath() is : 
request.getServletPath() is : /captchaImage
1234
```

例如返回图片文件：

```Java
request.getRequestURL() is : http://localhost:8080/profile/avatar/2020/07/31/8f04b7aa-c799-405b-90b0-4cfe36d89f35.jpeg
request.getRequestURI() is : /profile/avatar/2020/07/31/8f04b7aa-c799-405b-90b0-4cfe36d89f35.jpeg
request.getContextPath() is : 
request.getServletPath() is : /profile/avatar/2020/07/31/8f04b7aa-c799-405b-90b0-4cfe36d89f35.jpeg
1234
```