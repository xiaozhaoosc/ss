# bug

## 儿童管理

1. 新增儿童失败
   chunk-JDSL2H4L.js?v=bcfdac44:2365 Uncaught TypeError: proxy.resetForm is not a function
   at reset (index.vue:246:9)
   at handleAdd (index.vue:270:3)
2. 修改失败：

chunk-JDSL2H4L.js?v=bcfdac44:2365 Uncaught TypeError: proxy.resetForm is not a function
at reset (index.vue:246:9)
at Proxy.handleUpdate (index.vue:278:3)
at onClick (index.vue:91:62)

3. 删除失败：
 {code: 404, msg: "No endpoint DELETE /ssapi/ss/child/.", data: null}
code
: 
404
data
: 
null
msg
: 
"No endpoint DELETE /ssapi/ss/child/."