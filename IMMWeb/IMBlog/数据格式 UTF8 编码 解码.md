# iOS URL编码与解码

#背景

为什么在网络请求一段 URL 资源时, 要将 NSString 进行编码成 UTF-8, 或者其他类型等, 通常我们不会在浏览器上根本不会看到一段 URL 地址会包含 中文,大写,全角英文类型的字符,  一般都只会看到 0 - 9  数字, 26个英文字母, 以及一些特殊符号,  原因是 网络标准[RFC 1738](http://www.ietf.org/rfc/rfc1738.txt)规定url中只能包含英文字母和阿拉伯数字，以及一些特殊字符。

所以每次我们在请求 URL 资源时, 发送到后台要将字符进行一个编码。 

目前的编码格式很多,  我们看见最多的应该是ASCII 编码, Unicode 编码, UTF-8.

由于 ASSCII 码 包含集合并不是特别大, 后面扩展到 UTF-8 。




https://blog.csdn.net/andanlan/article/details/53368727

http://www.ruanyifeng.com/blog/2010/02/url_encoding.html

https://blog.csdn.net/gauss_li/article/details/45036299

http://damonfish.github.io/blog/2015/03/02/-iOS%E4%B8%AD%E7%9A%84%E7%BC%96%E7%A0%81%E9%97%AE%E9%A2%98%E6%80%BB%E7%BB%93/

