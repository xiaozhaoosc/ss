
# 1 vue报错
00:34:46 [vite] [plugin:vite:vue] [vue/compiler-sfc] Unexpected token (174:2)

D:/kenzhao/cust_projects/ss/smallsteps-app/src/pages/parent/insights/index.vue
172|        bgColor: index % 2 === 0 ? '#fef3c7' : '#e0f2fe'
173|      }))
174|    }).catch(err => {
|    ^
175|      console.error('Failed to load insights achievements:', err)
176|    })
at pages/parent/insights/index.vue:174:2
58 |        </view>
59 |  
60 |        <!-- 月度情绪热力图 -->
|     ^
61 |        <view class="section">
62 |          <text class="section-title">月度情绪热力图</text>


# 2 我的各项功能真实实现
![img.png](img.png)

# 3. 据账号权限自动分流

要在 Small Steps 应用中从家长端跳转到儿童端，主要有两种方式：一种是根据账号权限自动分流（正式环境）

1. 自动分流逻辑（正式环境）
   目前前端代码（user.ts）已经实现了基于用户信息的自动跳转。系统会根据后端返回的 getInfo() 数据中的 userType 或 roles 来决定你是谁：

* 判定为儿童的条件：
    * userType 字段值为 3 (后端定义)。
    * 或者 roles 列表中包含字符串 'child'。
* 跳转逻辑：
  在 pages/login/index.vue 中，登录成功后会执行以下代码：

1     if (userStore.role === 'child') {
2       uni.reLaunch({ url: '/pages/child/home/index' }) // 跳转到儿童首页
3     } else {
4       uni.reLaunch({ url: '/pages/parent/dashboard/index' }) // 跳转到家长首页
5     }

如何操作：你需要确保你的登录账号在数据库 sys_user 表中的 user_type 为 3，或者在 sys_role 中被分配了标识符为 child 的角色。


# 4. app报错
webextension.js:26 Uncaught TypeError: Cannot read properties of null (reading '1')
at webextension.js:26:68
at webextension.js:28:3
（匿名） @ webextension.js:26
（匿名） @ webextension.js:28了解此错误
pages-json-js:100  GET http://localhost:9090/src/pages/parent/insights/index.vue net::ERR_ABORTED 500 (Internal Server Error)
PagesParentInsightsIndexLoader @ pages-json-js:100
load @ vue.runtime.esm.js:3681
setup @ vue.runtime.esm.js:3760
callWithErrorHandling @ vue.runtime.esm.js:1381
setupStatefulComponent @ vue.runtime.esm.js:8957
setupComponent @ vue.runtime.esm.js:8918
mountComponent @ vue.runtime.esm.js:7234
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
updateComponent @ vue.runtime.esm.js:7277
processComponent @ vue.runtime.esm.js:7211
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
updateComponent @ vue.runtime.esm.js:7277
processComponent @ vue.runtime.esm.js:7211
patch @ vue.runtime.esm.js:6666
patchKeyedChildren @ vue.runtime.esm.js:7622
patchChildren @ vue.runtime.esm.js:7536
patchElement @ vue.runtime.esm.js:6961
processElement @ vue.runtime.esm.js:6797
patch @ vue.runtime.esm.js:6654
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
callWithErrorHandling @ vue.runtime.esm.js:1381
flushJobs @ vue.runtime.esm.js:1585
Promise.then
queueFlush @ vue.runtime.esm.js:1494
queueJob @ vue.runtime.esm.js:1488
scheduler @ vue.runtime.esm.js:3179
resetScheduling @ vue.runtime.esm.js:236
triggerEffects @ vue.runtime.esm.js:280
triggerRefValue @ vue.runtime.esm.js:1033
set value @ vue.runtime.esm.js:1078
finalizeNavigation @ vue-router.mjs?v=16a8caa8:2474
（匿名） @ vue-router.mjs?v=16a8caa8:2384
Promise.then
pushWithRedirect @ vue-router.mjs?v=16a8caa8:2352
push @ vue-router.mjs?v=16a8caa8:2278
install @ vue-router.mjs?v=16a8caa8:2631
use @ vue.runtime.esm.js:5146
initRouter @ uni-h5.es.js:16332
install @ uni-h5.es.js:16401
use @ vue.runtime.esm.js:5146
（匿名） @ main.js:24了解此错误
main.js:24 [Vue warn]: Unhandled error during execution of async component loader
at <AsyncComponentWrapper>
at <PageBody>
at <Page>
at <Anonymous>
at <KeepAlive>
at <RouterView>
at <Layout>
at <App>
warnHandler @ uni-h5.es.js:16421
callWithErrorHandling @ vue.runtime.esm.js:1381
warn$1 @ vue.runtime.esm.js:1207
logError @ vue.runtime.esm.js:1438
errorHandler @ uni-h5.es.js:16220
callWithErrorHandling @ vue.runtime.esm.js:1381
handleError @ vue.runtime.esm.js:1421
onError @ vue.runtime.esm.js:3724
（匿名） @ vue.runtime.esm.js:3767
Promise.catch
setup @ vue.runtime.esm.js:3766
callWithErrorHandling @ vue.runtime.esm.js:1381
setupStatefulComponent @ vue.runtime.esm.js:8957
setupComponent @ vue.runtime.esm.js:8918
mountComponent @ vue.runtime.esm.js:7234
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
updateComponent @ vue.runtime.esm.js:7277
processComponent @ vue.runtime.esm.js:7211
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
updateComponent @ vue.runtime.esm.js:7277
processComponent @ vue.runtime.esm.js:7211
patch @ vue.runtime.esm.js:6666
patchKeyedChildren @ vue.runtime.esm.js:7622
patchChildren @ vue.runtime.esm.js:7536
patchElement @ vue.runtime.esm.js:6961
processElement @ vue.runtime.esm.js:6797
patch @ vue.runtime.esm.js:6654
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
callWithErrorHandling @ vue.runtime.esm.js:1381
flushJobs @ vue.runtime.esm.js:1585
Promise.then
queueFlush @ vue.runtime.esm.js:1494
queueJob @ vue.runtime.esm.js:1488
scheduler @ vue.runtime.esm.js:3179
resetScheduling @ vue.runtime.esm.js:236
triggerEffects @ vue.runtime.esm.js:280
triggerRefValue @ vue.runtime.esm.js:1033
set value @ vue.runtime.esm.js:1078
finalizeNavigation @ vue-router.mjs?v=16a8caa8:2474
（匿名） @ vue-router.mjs?v=16a8caa8:2384
Promise.then
pushWithRedirect @ vue-router.mjs?v=16a8caa8:2352
push @ vue-router.mjs?v=16a8caa8:2278
install @ vue-router.mjs?v=16a8caa8:2631
use @ vue.runtime.esm.js:5146
initRouter @ uni-h5.es.js:16332
install @ uni-h5.es.js:16401
use @ vue.runtime.esm.js:5146
（匿名） @ main.js:24了解此警告
main.js:24 TypeError: Failed to fetch dynamically imported module: http://localhost:9090/src/pages/parent/insights/index.vue
logError @ vue.runtime.esm.js:1443
errorHandler @ uni-h5.es.js:16220
callWithErrorHandling @ vue.runtime.esm.js:1381
handleError @ vue.runtime.esm.js:1421
onError @ vue.runtime.esm.js:3724
（匿名） @ vue.runtime.esm.js:3767
Promise.catch
setup @ vue.runtime.esm.js:3766
callWithErrorHandling @ vue.runtime.esm.js:1381
setupStatefulComponent @ vue.runtime.esm.js:8957
setupComponent @ vue.runtime.esm.js:8918
mountComponent @ vue.runtime.esm.js:7234
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
updateComponent @ vue.runtime.esm.js:7277
processComponent @ vue.runtime.esm.js:7211
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
updateComponent @ vue.runtime.esm.js:7277
processComponent @ vue.runtime.esm.js:7211
patch @ vue.runtime.esm.js:6666
patchKeyedChildren @ vue.runtime.esm.js:7622
patchChildren @ vue.runtime.esm.js:7536
patchElement @ vue.runtime.esm.js:6961
processElement @ vue.runtime.esm.js:6797
patch @ vue.runtime.esm.js:6654
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
callWithErrorHandling @ vue.runtime.esm.js:1381
flushJobs @ vue.runtime.esm.js:1585
Promise.then
queueFlush @ vue.runtime.esm.js:1494
queueJob @ vue.runtime.esm.js:1488
scheduler @ vue.runtime.esm.js:3179
resetScheduling @ vue.runtime.esm.js:236
triggerEffects @ vue.runtime.esm.js:280
triggerRefValue @ vue.runtime.esm.js:1033
set value @ vue.runtime.esm.js:1078
finalizeNavigation @ vue-router.mjs?v=16a8caa8:2474
（匿名） @ vue-router.mjs?v=16a8caa8:2384
Promise.then
pushWithRedirect @ vue-router.mjs?v=16a8caa8:2352
push @ vue-router.mjs?v=16a8caa8:2278
install @ vue-router.mjs?v=16a8caa8:2631
use @ vue.runtime.esm.js:5146
initRouter @ uni-h5.es.js:16332
install @ uni-h5.es.js:16401
use @ vue.runtime.esm.js:5146
（匿名） @ main.js:24了解此错误
vue-router.mjs?v=16a8caa8:31 [Vue Router warn]: No match found for location with path "/pages/"
warn @ vue-router.mjs?v=16a8caa8:31
resolve @ vue-router.mjs?v=16a8caa8:2194
（匿名） @ vue-router.mjs?v=16a8caa8:2485
（匿名） @ vue-router.mjs?v=16a8caa8:298
popStateHandler @ vue-router.mjs?v=16a8caa8:297了解此警告
uni-h5.es.js:9846 [Intervention] Slow network is detected. See https://www.chromestatus.com/feature/5636954674692096 for more details. Fallback font will be used while loading: http://localhost:9090/src/static/font/iconfont.ttf
uni-h5.es.js:2727 Uncaught (in promise) {errMsg: 'switchTab:fail Navigation cancelled from "/" to "/pages/parent/profile/index" with a new navigation.'}
（匿名） @ uni-h5.es.js:2727
（匿名） @ uni-h5.es.js:2824
invokeCallback @ uni-h5.es.js:2750
invokeFail @ uni-h5.es.js:3010
reject @ uni-h5.es.js:3086
Promise.catch
（匿名） @ uni-h5.es.js:7089
handleBeforeEntryPageRoutes @ uni-h5.es.js:7088
（匿名） @ uni-h5.es.js:7238
setTimeout
initPage @ uni-h5.es.js:7237
comp.setup @ uni-h5.es.js:16487
callWithErrorHandling @ vue.runtime.esm.js:1381
setupStatefulComponent @ vue.runtime.esm.js:8957
setupComponent @ vue.runtime.esm.js:8918
mountComponent @ vue.runtime.esm.js:7234
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
callWithErrorHandling @ vue.runtime.esm.js:1381
flushJobs @ vue.runtime.esm.js:1585
Promise.then
queueFlush @ vue.runtime.esm.js:1494
queueJob @ vue.runtime.esm.js:1488
（匿名） @ vue.runtime.esm.js:7463
resetScheduling @ vue.runtime.esm.js:236
triggerEffects @ vue.runtime.esm.js:280
triggerRefValue @ vue.runtime.esm.js:1033
set value @ vue.runtime.esm.js:1078
（匿名） @ vue.runtime.esm.js:3761
Promise.then
setup @ vue.runtime.esm.js:3760
callWithErrorHandling @ vue.runtime.esm.js:1381
setupStatefulComponent @ vue.runtime.esm.js:8957
setupComponent @ vue.runtime.esm.js:8918
mountComponent @ vue.runtime.esm.js:7234
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
updateComponent @ vue.runtime.esm.js:7277
processComponent @ vue.runtime.esm.js:7211
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
callWithErrorHandling @ vue.runtime.esm.js:1381
flushJobs @ vue.runtime.esm.js:1585
Promise.then
queueFlush @ vue.runtime.esm.js:1494
queueJob @ vue.runtime.esm.js:1488
scheduler @ vue.runtime.esm.js:3179
resetScheduling @ vue.runtime.esm.js:236
triggerEffects @ vue.runtime.esm.js:280
triggerRefValue @ vue.runtime.esm.js:1033
set value @ vue.runtime.esm.js:1078
finalizeNavigation @ vue-router.mjs?v=16a8caa8:2474
（匿名） @ vue-router.mjs?v=16a8caa8:2529
Promise.then
（匿名） @ vue-router.mjs?v=16a8caa8:2528
（匿名） @ vue-router.mjs?v=16a8caa8:298
popStateHandler @ vue-router.mjs?v=16a8caa8:297了解此错误
uni-h5.es.js:2727 Uncaught (in promise) {errMsg: 'switchTab:fail Navigation cancelled from "/" to "/pages/parent/profile/index" with a new navigation.'}
（匿名） @ uni-h5.es.js:2727
（匿名） @ uni-h5.es.js:2824
invokeCallback @ uni-h5.es.js:2750
invokeFail @ uni-h5.es.js:3010
reject @ uni-h5.es.js:3086
Promise.catch
（匿名） @ uni-h5.es.js:7089
handleBeforeEntryPageRoutes @ uni-h5.es.js:7088
（匿名） @ uni-h5.es.js:7238
setTimeout
initPage @ uni-h5.es.js:7237
comp.setup @ uni-h5.es.js:16487
callWithErrorHandling @ vue.runtime.esm.js:1381
setupStatefulComponent @ vue.runtime.esm.js:8957
setupComponent @ vue.runtime.esm.js:8918
mountComponent @ vue.runtime.esm.js:7234
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
callWithErrorHandling @ vue.runtime.esm.js:1381
flushJobs @ vue.runtime.esm.js:1585
Promise.then
queueFlush @ vue.runtime.esm.js:1494
queueJob @ vue.runtime.esm.js:1488
（匿名） @ vue.runtime.esm.js:7463
resetScheduling @ vue.runtime.esm.js:236
triggerEffects @ vue.runtime.esm.js:280
triggerRefValue @ vue.runtime.esm.js:1033
set value @ vue.runtime.esm.js:1078
（匿名） @ vue.runtime.esm.js:3761
Promise.then
setup @ vue.runtime.esm.js:3760
callWithErrorHandling @ vue.runtime.esm.js:1381
setupStatefulComponent @ vue.runtime.esm.js:8957
setupComponent @ vue.runtime.esm.js:8918
mountComponent @ vue.runtime.esm.js:7234
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
updateComponent @ vue.runtime.esm.js:7277
processComponent @ vue.runtime.esm.js:7211
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
callWithErrorHandling @ vue.runtime.esm.js:1381
flushJobs @ vue.runtime.esm.js:1585
Promise.then
queueFlush @ vue.runtime.esm.js:1494
queueJob @ vue.runtime.esm.js:1488
scheduler @ vue.runtime.esm.js:3179
resetScheduling @ vue.runtime.esm.js:236
triggerEffects @ vue.runtime.esm.js:280
triggerRefValue @ vue.runtime.esm.js:1033
set value @ vue.runtime.esm.js:1078
finalizeNavigation @ vue-router.mjs?v=16a8caa8:2474
（匿名） @ vue-router.mjs?v=16a8caa8:2529
Promise.then
（匿名） @ vue-router.mjs?v=16a8caa8:2528
（匿名） @ vue-router.mjs?v=16a8caa8:298
popStateHandler @ vue-router.mjs?v=16a8caa8:297了解此错误
uni-h5.es.js:2727 Uncaught (in promise) {errMsg: 'switchTab:fail Navigation cancelled from "/" to "/pages/parent/profile/index" with a new navigation.'}
（匿名） @ uni-h5.es.js:2727
（匿名） @ uni-h5.es.js:2824
invokeCallback @ uni-h5.es.js:2750
invokeFail @ uni-h5.es.js:3010
reject @ uni-h5.es.js:3086
Promise.catch
（匿名） @ uni-h5.es.js:7089
handleBeforeEntryPageRoutes @ uni-h5.es.js:7088
（匿名） @ uni-h5.es.js:7238
setTimeout
initPage @ uni-h5.es.js:7237
comp.setup @ uni-h5.es.js:16487
callWithErrorHandling @ vue.runtime.esm.js:1381
setupStatefulComponent @ vue.runtime.esm.js:8957
setupComponent @ vue.runtime.esm.js:8918
mountComponent @ vue.runtime.esm.js:7234
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
callWithErrorHandling @ vue.runtime.esm.js:1381
flushJobs @ vue.runtime.esm.js:1585
Promise.then
queueFlush @ vue.runtime.esm.js:1494
queueJob @ vue.runtime.esm.js:1488
（匿名） @ vue.runtime.esm.js:7463
resetScheduling @ vue.runtime.esm.js:236
triggerEffects @ vue.runtime.esm.js:280
triggerRefValue @ vue.runtime.esm.js:1033
set value @ vue.runtime.esm.js:1078
（匿名） @ vue.runtime.esm.js:3761
Promise.then
setup @ vue.runtime.esm.js:3760
callWithErrorHandling @ vue.runtime.esm.js:1381
setupStatefulComponent @ vue.runtime.esm.js:8957
setupComponent @ vue.runtime.esm.js:8918
mountComponent @ vue.runtime.esm.js:7234
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
updateComponent @ vue.runtime.esm.js:7277
processComponent @ vue.runtime.esm.js:7211
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
callWithErrorHandling @ vue.runtime.esm.js:1381
flushJobs @ vue.runtime.esm.js:1585
Promise.then
queueFlush @ vue.runtime.esm.js:1494
queueJob @ vue.runtime.esm.js:1488
scheduler @ vue.runtime.esm.js:3179
resetScheduling @ vue.runtime.esm.js:236
triggerEffects @ vue.runtime.esm.js:280
triggerRefValue @ vue.runtime.esm.js:1033
set value @ vue.runtime.esm.js:1078
finalizeNavigation @ vue-router.mjs?v=16a8caa8:2474
（匿名） @ vue-router.mjs?v=16a8caa8:2529
Promise.then
（匿名） @ vue-router.mjs?v=16a8caa8:2528
（匿名） @ vue-router.mjs?v=16a8caa8:298
popStateHandler @ vue-router.mjs?v=16a8caa8:297了解此错误
bottom-nav.vue:69 [Vue warn]: Unhandled error during execution of async component loader
at <AsyncComponentWrapper>
at <PageBody>
at <Page>
at <Anonymous>
at <KeepAlive>
at <RouterView>
at <Layout>
at <App>
warnHandler @ uni-h5.es.js:16421
callWithErrorHandling @ vue.runtime.esm.js:1381
warn$1 @ vue.runtime.esm.js:1207
logError @ vue.runtime.esm.js:1438
errorHandler @ uni-h5.es.js:16220
callWithErrorHandling @ vue.runtime.esm.js:1381
handleError @ vue.runtime.esm.js:1421
onError @ vue.runtime.esm.js:3724
（匿名） @ vue.runtime.esm.js:3767
Promise.catch
setup @ vue.runtime.esm.js:3766
callWithErrorHandling @ vue.runtime.esm.js:1381
setupStatefulComponent @ vue.runtime.esm.js:8957
setupComponent @ vue.runtime.esm.js:8918
mountComponent @ vue.runtime.esm.js:7234
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
updateComponent @ vue.runtime.esm.js:7277
processComponent @ vue.runtime.esm.js:7211
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
callWithErrorHandling @ vue.runtime.esm.js:1381
flushJobs @ vue.runtime.esm.js:1585
Promise.then
queueFlush @ vue.runtime.esm.js:1494
queueJob @ vue.runtime.esm.js:1488
scheduler @ vue.runtime.esm.js:3179
resetScheduling @ vue.runtime.esm.js:236
triggerEffects @ vue.runtime.esm.js:280
triggerRefValue @ vue.runtime.esm.js:1033
set value @ vue.runtime.esm.js:1078
finalizeNavigation @ vue-router.mjs?v=16a8caa8:2474
（匿名） @ vue-router.mjs?v=16a8caa8:2384
Promise.then
pushWithRedirect @ vue-router.mjs?v=16a8caa8:2352
push @ vue-router.mjs?v=16a8caa8:2278
replace @ vue-router.mjs?v=16a8caa8:2281
（匿名） @ uni-h5.es.js:7037
navigate @ uni-h5.es.js:7035
（匿名） @ uni-h5.es.js:6968
（匿名） @ uni-h5.es.js:3084
invokeApi @ uni-h5.es.js:2932
（匿名） @ uni-h5.es.js:2950
（匿名） @ bottom-nav.vue:69
（匿名） @ bottom-nav.vue:8
callWithErrorHandling @ vue.runtime.esm.js:1381
callWithAsyncErrorHandling @ vue.runtime.esm.js:1388
invoker @ vue.runtime.esm.js:10227了解此警告
bottom-nav.vue:69 TypeError: Failed to fetch dynamically imported module: http://localhost:9090/src/pages/parent/insights/index.vue
logError @ vue.runtime.esm.js:1443
errorHandler @ uni-h5.es.js:16220
callWithErrorHandling @ vue.runtime.esm.js:1381
handleError @ vue.runtime.esm.js:1421
onError @ vue.runtime.esm.js:3724
（匿名） @ vue.runtime.esm.js:3767
Promise.catch
setup @ vue.runtime.esm.js:3766
callWithErrorHandling @ vue.runtime.esm.js:1381
setupStatefulComponent @ vue.runtime.esm.js:8957
setupComponent @ vue.runtime.esm.js:8918
mountComponent @ vue.runtime.esm.js:7234
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
updateComponent @ vue.runtime.esm.js:7277
processComponent @ vue.runtime.esm.js:7211
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
callWithErrorHandling @ vue.runtime.esm.js:1381
flushJobs @ vue.runtime.esm.js:1585
Promise.then
queueFlush @ vue.runtime.esm.js:1494
queueJob @ vue.runtime.esm.js:1488
scheduler @ vue.runtime.esm.js:3179
resetScheduling @ vue.runtime.esm.js:236
triggerEffects @ vue.runtime.esm.js:280
triggerRefValue @ vue.runtime.esm.js:1033
set value @ vue.runtime.esm.js:1078
finalizeNavigation @ vue-router.mjs?v=16a8caa8:2474
（匿名） @ vue-router.mjs?v=16a8caa8:2384
Promise.then
pushWithRedirect @ vue-router.mjs?v=16a8caa8:2352
push @ vue-router.mjs?v=16a8caa8:2278
replace @ vue-router.mjs?v=16a8caa8:2281
（匿名） @ uni-h5.es.js:7037
navigate @ uni-h5.es.js:7035
（匿名） @ uni-h5.es.js:6968
（匿名） @ uni-h5.es.js:3084
invokeApi @ uni-h5.es.js:2932
（匿名） @ uni-h5.es.js:2950
（匿名） @ bottom-nav.vue:69
（匿名） @ bottom-nav.vue:8
callWithErrorHandling @ vue.runtime.esm.js:1381
callWithAsyncErrorHandling @ vue.runtime.esm.js:1388
invoker @ vue.runtime.esm.js:10227了解此错误
bottom-nav.vue:69 [Vue warn]: Unhandled error during execution of async component loader
at <AsyncComponentWrapper>
at <PageBody>
at <Page>
at <Anonymous>
at <KeepAlive>
at <RouterView>
at <Layout>
at <App>
warnHandler @ uni-h5.es.js:16421
callWithErrorHandling @ vue.runtime.esm.js:1381
warn$1 @ vue.runtime.esm.js:1207
logError @ vue.runtime.esm.js:1438
errorHandler @ uni-h5.es.js:16220
callWithErrorHandling @ vue.runtime.esm.js:1381
handleError @ vue.runtime.esm.js:1421
onError @ vue.runtime.esm.js:3724
（匿名） @ vue.runtime.esm.js:3767
Promise.catch
setup @ vue.runtime.esm.js:3766
callWithErrorHandling @ vue.runtime.esm.js:1381
setupStatefulComponent @ vue.runtime.esm.js:8957
setupComponent @ vue.runtime.esm.js:8918
mountComponent @ vue.runtime.esm.js:7234
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
updateComponent @ vue.runtime.esm.js:7277
processComponent @ vue.runtime.esm.js:7211
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
callWithErrorHandling @ vue.runtime.esm.js:1381
flushJobs @ vue.runtime.esm.js:1585
Promise.then
queueFlush @ vue.runtime.esm.js:1494
queueJob @ vue.runtime.esm.js:1488
scheduler @ vue.runtime.esm.js:3179
resetScheduling @ vue.runtime.esm.js:236
triggerEffects @ vue.runtime.esm.js:280
triggerRefValue @ vue.runtime.esm.js:1033
set value @ vue.runtime.esm.js:1078
finalizeNavigation @ vue-router.mjs?v=16a8caa8:2474
（匿名） @ vue-router.mjs?v=16a8caa8:2384
Promise.then
pushWithRedirect @ vue-router.mjs?v=16a8caa8:2352
push @ vue-router.mjs?v=16a8caa8:2278
replace @ vue-router.mjs?v=16a8caa8:2281
（匿名） @ uni-h5.es.js:7037
navigate @ uni-h5.es.js:7035
（匿名） @ uni-h5.es.js:6968
（匿名） @ uni-h5.es.js:3084
invokeApi @ uni-h5.es.js:2932
（匿名） @ uni-h5.es.js:2950
（匿名） @ bottom-nav.vue:69
（匿名） @ bottom-nav.vue:8
callWithErrorHandling @ vue.runtime.esm.js:1381
callWithAsyncErrorHandling @ vue.runtime.esm.js:1388
invoker @ vue.runtime.esm.js:10227了解此警告
bottom-nav.vue:69 TypeError: Failed to fetch dynamically imported module: http://localhost:9090/src/pages/parent/insights/index.vue
logError @ vue.runtime.esm.js:1443
errorHandler @ uni-h5.es.js:16220
callWithErrorHandling @ vue.runtime.esm.js:1381
handleError @ vue.runtime.esm.js:1421
onError @ vue.runtime.esm.js:3724
（匿名） @ vue.runtime.esm.js:3767
Promise.catch
setup @ vue.runtime.esm.js:3766
callWithErrorHandling @ vue.runtime.esm.js:1381
setupStatefulComponent @ vue.runtime.esm.js:8957
setupComponent @ vue.runtime.esm.js:8918
mountComponent @ vue.runtime.esm.js:7234
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
updateComponent @ vue.runtime.esm.js:7277
processComponent @ vue.runtime.esm.js:7211
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
callWithErrorHandling @ vue.runtime.esm.js:1381
flushJobs @ vue.runtime.esm.js:1585
Promise.then
queueFlush @ vue.runtime.esm.js:1494
queueJob @ vue.runtime.esm.js:1488
scheduler @ vue.runtime.esm.js:3179
resetScheduling @ vue.runtime.esm.js:236
triggerEffects @ vue.runtime.esm.js:280
triggerRefValue @ vue.runtime.esm.js:1033
set value @ vue.runtime.esm.js:1078
finalizeNavigation @ vue-router.mjs?v=16a8caa8:2474
（匿名） @ vue-router.mjs?v=16a8caa8:2384
Promise.then
pushWithRedirect @ vue-router.mjs?v=16a8caa8:2352
push @ vue-router.mjs?v=16a8caa8:2278
replace @ vue-router.mjs?v=16a8caa8:2281
（匿名） @ uni-h5.es.js:7037
navigate @ uni-h5.es.js:7035
（匿名） @ uni-h5.es.js:6968
（匿名） @ uni-h5.es.js:3084
invokeApi @ uni-h5.es.js:2932
（匿名） @ uni-h5.es.js:2950
（匿名） @ bottom-nav.vue:69
（匿名） @ bottom-nav.vue:8
callWithErrorHandling @ vue.runtime.esm.js:1381
callWithAsyncErrorHandling @ vue.runtime.esm.js:1388
invoker @ vue.runtime.esm.js:10227了解此错误
uni-h5.es.js:2727 Uncaught (in promise) {errMsg: 'hideTabBar:fail not TabBar page'}
（匿名） @ uni-h5.es.js:2727
（匿名） @ uni-h5.es.js:2824
invokeCallback @ uni-h5.es.js:2750
invokeFail @ uni-h5.es.js:3010
reject @ uni-h5.es.js:3086
setTabBar @ uni-h5.es.js:23139
（匿名） @ uni-h5.es.js:23212
（匿名） @ uni-h5.es.js:3084
invokeApi @ uni-h5.es.js:2932
（匿名） @ uni-h5.es.js:2957
（匿名） @ uni-h5.es.js:2956
（匿名） @ index.vue:183
callWithErrorHandling @ vue.runtime.esm.js:1381
callWithAsyncErrorHandling @ vue.runtime.esm.js:1388
hook.__weh.hook.__weh @ vue.runtime.esm.js:4141
invokeArrayFns @ uni-shared.es.js:1208
invokeHook @ uni-h5.es.js:1205
initHooks @ uni-h5.es.js:16183
applyOptions @ uni-h5.es.js:16192
applyOptions @ vue.runtime.esm.js:4877
finishComponentSetup @ vue.runtime.esm.js:9066
handleSetupResult @ vue.runtime.esm.js:9017
setupStatefulComponent @ vue.runtime.esm.js:8986
setupComponent @ vue.runtime.esm.js:8918
mountComponent @ vue.runtime.esm.js:7234
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
callWithErrorHandling @ vue.runtime.esm.js:1381
flushJobs @ vue.runtime.esm.js:1585
Promise.then
queueFlush @ vue.runtime.esm.js:1494
queueJob @ vue.runtime.esm.js:1488
（匿名） @ vue.runtime.esm.js:7463
resetScheduling @ vue.runtime.esm.js:236
triggerEffects @ vue.runtime.esm.js:280
triggerRefValue @ vue.runtime.esm.js:1033
set value @ vue.runtime.esm.js:1078
（匿名） @ vue.runtime.esm.js:3761
Promise.then
setup @ vue.runtime.esm.js:3760
callWithErrorHandling @ vue.runtime.esm.js:1381
setupStatefulComponent @ vue.runtime.esm.js:8957
setupComponent @ vue.runtime.esm.js:8918
mountComponent @ vue.runtime.esm.js:7234
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
updateComponent @ vue.runtime.esm.js:7277
processComponent @ vue.runtime.esm.js:7211
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
callWithErrorHandling @ vue.runtime.esm.js:1381
flushJobs @ vue.runtime.esm.js:1585
Promise.then
queueFlush @ vue.runtime.esm.js:1494
queueJob @ vue.runtime.esm.js:1488
scheduler @ vue.runtime.esm.js:3179
resetScheduling @ vue.runtime.esm.js:236
triggerEffects @ vue.runtime.esm.js:280
triggerRefValue @ vue.runtime.esm.js:1033
set value @ vue.runtime.esm.js:1078
finalizeNavigation @ vue-router.mjs?v=16a8caa8:2474
（匿名） @ vue-router.mjs?v=16a8caa8:2384
Promise.then
pushWithRedirect @ vue-router.mjs?v=16a8caa8:2352
push @ vue-router.mjs?v=16a8caa8:2278
replace @ vue-router.mjs?v=16a8caa8:2281
（匿名） @ uni-h5.es.js:7037
navigate @ uni-h5.es.js:7035
（匿名） @ uni-h5.es.js:7022
（匿名） @ uni-h5.es.js:3084
invokeApi @ uni-h5.es.js:2932
（匿名） @ uni-h5.es.js:2957
（匿名） @ uni-h5.es.js:2956
handleLogin @ index.vue:232
await in handleLogin
patchedFn @ vue.runtime.esm.js:10247
callWithErrorHandling @ vue.runtime.esm.js:1381
callWithAsyncErrorHandling @ vue.runtime.esm.js:1388
invoker @ vue.runtime.esm.js:10218了解此错误
user.ts:117 Fetch balance failed 500
（匿名） @ user.ts:117
await in （匿名）
wrappedAction @ pinia.mjs:1069
store.<computed> @ pinia.mjs:747
（匿名） @ index.vue:186
callWithErrorHandling @ vue.runtime.esm.js:1381
callWithAsyncErrorHandling @ vue.runtime.esm.js:1388
hook.__weh.hook.__weh @ vue.runtime.esm.js:4141
invokeArrayFns @ uni-shared.es.js:1208
invokeHook @ uni-h5.es.js:1205
initHooks @ uni-h5.es.js:16183
applyOptions @ uni-h5.es.js:16192
applyOptions @ vue.runtime.esm.js:4877
finishComponentSetup @ vue.runtime.esm.js:9066
handleSetupResult @ vue.runtime.esm.js:9017
setupStatefulComponent @ vue.runtime.esm.js:8986
setupComponent @ vue.runtime.esm.js:8918
mountComponent @ vue.runtime.esm.js:7234
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
callWithErrorHandling @ vue.runtime.esm.js:1381
flushJobs @ vue.runtime.esm.js:1585
Promise.then
queueFlush @ vue.runtime.esm.js:1494
queueJob @ vue.runtime.esm.js:1488
（匿名） @ vue.runtime.esm.js:7463
resetScheduling @ vue.runtime.esm.js:236
triggerEffects @ vue.runtime.esm.js:280
triggerRefValue @ vue.runtime.esm.js:1033
set value @ vue.runtime.esm.js:1078
（匿名） @ vue.runtime.esm.js:3761
Promise.then
setup @ vue.runtime.esm.js:3760
callWithErrorHandling @ vue.runtime.esm.js:1381
setupStatefulComponent @ vue.runtime.esm.js:8957
setupComponent @ vue.runtime.esm.js:8918
mountComponent @ vue.runtime.esm.js:7234
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
mountChildren @ vue.runtime.esm.js:6914
processFragment @ vue.runtime.esm.js:7130
patch @ vue.runtime.esm.js:6640
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
mountChildren @ vue.runtime.esm.js:6914
mountElement @ vue.runtime.esm.js:6821
processElement @ vue.runtime.esm.js:6786
patch @ vue.runtime.esm.js:6654
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7344
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
setupRenderEffect @ vue.runtime.esm.js:7479
mountComponent @ vue.runtime.esm.js:7246
processComponent @ vue.runtime.esm.js:7200
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
updateComponent @ vue.runtime.esm.js:7277
processComponent @ vue.runtime.esm.js:7211
patch @ vue.runtime.esm.js:6666
componentUpdateFn @ vue.runtime.esm.js:7425
run @ vue.runtime.esm.js:153
instance.update @ vue.runtime.esm.js:7469
callWithErrorHandling @ vue.runtime.esm.js:1381
flushJobs @ vue.runtime.esm.js:1585
Promise.then
queueFlush @ vue.runtime.esm.js:1494
queueJob @ vue.runtime.esm.js:1488
scheduler @ vue.runtime.esm.js:3179
resetScheduling @ vue.runtime.esm.js:236
triggerEffects @ vue.runtime.esm.js:280
triggerRefValue @ vue.runtime.esm.js:1033
set value @ vue.runtime.esm.js:1078
finalizeNavigation @ vue-router.mjs?v=16a8caa8:2474
（匿名） @ vue-router.mjs?v=16a8caa8:2384
Promise.then
pushWithRedirect @ vue-router.mjs?v=16a8caa8:2352
push @ vue-router.mjs?v=16a8caa8:2278
replace @ vue-router.mjs?v=16a8caa8:2281
（匿名） @ uni-h5.es.js:7037
navigate @ uni-h5.es.js:7035
（匿名） @ uni-h5.es.js:7022
（匿名） @ uni-h5.es.js:3084
invokeApi @ uni-h5.es.js:2932
（匿名） @ uni-h5.es.js:2957
（匿名） @ uni-h5.es.js:2956
handleLogin @ index.vue:232
await in handleLogin
patchedFn @ vue.runtime.esm.js:10247
callWithErrorHandling @ vue.runtime.esm.js:1381
callWithAsyncErrorHandling @ vue.runtime.esm.js:1388
invoker @ vue.runtime.esm.js:10218了解此错误
uni-h5.es.js:2727 Uncaught (in promise) {errMsg: 'hideTabBar:fail not TabBar page'}
（匿名） @ uni-h5.es.js:2727
（匿名） @ uni-h5.es.js:2824
invokeCallback @ uni-h5.es.js:2750
invokeFail @ uni-h5.es.js:3010
reject @ uni-h5.es.js:3086
setTabBar @ uni-h5.es.js:23139
（匿名） @ uni-h5.es.js:23212
（匿名） @ uni-h5.es.js:3084
invokeApi @ uni-h5.es.js:2932
（匿名） @ uni-h5.es.js:2957
（匿名） @ uni-h5.es.js:2956
（匿名） @ index.vue:183
callWithErrorHandling @ vue.runtime.esm.js:1381
callWithAsyncErrorHandling @ vue.runtime.esm.js:1388
hook.__weh.hook.__weh @ vue.runtime.esm.js:4141
invokeArrayFns @ uni-shared.es.js:1208
invokeHook @ uni-h5.es.js:1205
onAppEnterForeground @ uni-h5.es.js:1753
emit @ uni-shared.es.js:2188
emit @ uni-h5.es.js:585
onVisibilityChange @ uni-h5.es.js:16672了解此错误
user.ts:117 Fetch balance failed 500

# 5 后端异常处理
2026-04-24 00:40:22 [XNIO-1 task-2] ERROR c.k.s.c.w.h.GlobalExceptionHandler
- 请求地址'/ssapi/parent/reward/score/1002',发生未知异常.
  org.springframework.jdbc.BadSqlGrammarException:
### Error querying database.  Cause: org.postgresql.util.PSQLException: ERROR: column "create_dept" does not exist
位置：38
### The error may exist in com/kenzhao/smallsteps/child/mapper/ChildScoreMapper.java (best guess)
### The error may involve defaultParameterMap
### The error occurred while setting parameters
### SQL: SELECT  user_id,balance,total_earned,create_dept,create_by,create_time,update_by,update_time  FROM ss_child_score      WHERE  (user_id = ?)
### Cause: org.postgresql.util.PSQLException: ERROR: column "create_dept" does not exist
位置：38
; bad SQL grammar []
at org.springframework.jdbc.support.SQLStateSQLExceptionTranslator.doTranslate(SQLStateSQLExceptionTranslator.java:134)
at org.springframework.jdbc.support.AbstractFallbackSQLExceptionTranslator.translate(AbstractFallbackSQLExceptionTranslator.java:107)
at org.springframework.jdbc.support.AbstractFallbackSQLExceptionTranslator.translate(AbstractFallbackSQLExceptionTranslator.java:116)
at org.springframework.jdbc.support.AbstractFallbackSQLExceptionTranslator.translate(AbstractFallbackSQLExceptionTranslator.java:116)
at org.mybatis.spring.MyBatisExceptionTranslator.translateExceptionIfPossible(MyBatisExceptionTranslator.java:95)
at org.mybatis.spring.SqlSessionTemplate$SqlSessionInterceptor.invoke(SqlSessionTemplate.java:347)
at jdk.proxy2/jdk.proxy2.$Proxy136.selectList(Unknown Source)
at org.mybatis.spring.SqlSessionTemplate.selectList(SqlSessionTemplate.java:194)
at com.baomidou.mybatisplus.core.override.MybatisMapperMethod.executeForMany(MybatisMapperMethod.java:164)
at com.baomidou.mybatisplus.core.override.MybatisMapperMethod.execute(MybatisMapperMethod.java:77)
at com.baomidou.mybatisplus.core.override.MybatisMapperProxy$PlainMethodInvoker.invoke(MybatisMapperProxy.java:156)
at com.baomidou.mybatisplus.core.override.MybatisMapperProxy.invoke(MybatisMapperProxy.java:93)
at jdk.proxy2/jdk.proxy2.$Proxy192.selectList(Unknown Source)
at com.baomidou.mybatisplus.core.mapper.BaseMapper.selectOne(BaseMapper.java:337)
at java.base/java.lang.invoke.MethodHandle.invokeWithArguments(MethodHandle.java:733)
at com.baomidou.mybatisplus.core.override.MybatisMapperProxy$DefaultMethodInvoker.invoke(MybatisMapperProxy.java:172)
at com.baomidou.mybatisplus.core.override.MybatisMapperProxy.invoke(MybatisMapperProxy.java:93)
at jdk.proxy2/jdk.proxy2.$Proxy192.selectOne(Unknown Source)
at com.baomidou.mybatisplus.core.mapper.BaseMapper.selectOne(BaseMapper.java:326)
at java.base/java.lang.invoke.MethodHandle.invokeWithArguments(MethodHandle.java:733)
at com.baomidou.mybatisplus.core.override.MybatisMapperProxy$DefaultMethodInvoker.invoke(MybatisMapperProxy.java:182)
at com.baomidou.mybatisplus.core.override.MybatisMapperProxy.invoke(MybatisMapperProxy.java:93)
at jdk.proxy2/jdk.proxy2.$Proxy192.selectOne(Unknown Source)
at com.kenzhao.smallsteps.child.service.impl.ScoreServiceImpl.getChildScore(ScoreServiceImpl.java:32)
at com.kenzhao.smallsteps.parent.controller.ParentRewardController.getScore(ParentRewardController.java:119)
at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
at java.base/java.lang.reflect.Method.invoke(Method.java:580)
at org.springframework.aop.support.AopUtils.invokeJoinpointUsingReflection(AopUtils.java:360)
at org.springframework.aop.framework.ReflectiveMethodInvocation.invokeJoinpoint(ReflectiveMethodInvocation.java:196)
at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:163)
at org.springframework.validation.beanvalidation.MethodValidationInterceptor.invoke(MethodValidationInterceptor.java:172)
at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:184)
at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:97)
at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:184)
at org.springframework.aop.framework.CglibAopProxy$DynamicAdvisedInterceptor.intercept(CglibAopProxy.java:728)
at com.kenzhao.smallsteps.parent.controller.ParentRewardController$$SpringCGLIB$$0.getScore(<generated>)
at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
at java.base/java.lang.reflect.Method.invoke(Method.java:580)
at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:258)
at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:191)
at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:118)
at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:991)
at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:896)
at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:87)
at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1089)
at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:979)
at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1014)
at org.springframework.web.servlet.FrameworkServlet.doGet(FrameworkServlet.java:903)
at jakarta.servlet.http.HttpServlet.service(HttpServlet.java:527)
at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:885)
at jakarta.servlet.http.HttpServlet.service(HttpServlet.java:614)
at io.undertow.servlet.handlers.ServletHandler.handleRequest(ServletHandler.java:74)
at io.undertow.servlet.handlers.FilterHandler$FilterChainImpl.doFilter(FilterHandler.java:129)
at org.springframework.web.filter.CorsFilter.doFilterInternal(CorsFilter.java:91)
at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:116)
at io.undertow.servlet.core.ManagedFilter.doFilter(ManagedFilter.java:67)
at io.undertow.servlet.handlers.FilterHandler$FilterChainImpl.doFilter(FilterHandler.java:131)
at com.kenzhao.smallsteps.common.web.filter.RepeatableFilter.doFilter(RepeatableFilter.java:30)
at io.undertow.servlet.core.ManagedFilter.doFilter(ManagedFilter.java:67)
at io.undertow.servlet.handlers.FilterHandler$FilterChainImpl.doFilter(FilterHandler.java:131)
at cn.dev33.satoken.filter.SaServletFilter.doFilter(SaServletFilter.java:143)
at io.undertow.servlet.core.ManagedFilter.doFilter(ManagedFilter.java:67)
at io.undertow.servlet.handlers.FilterHandler$FilterChainImpl.doFilter(FilterHandler.java:131)
at cn.dev33.satoken.filter.SaFirewallCheckFilterForJakartaServlet.doFilter(SaFirewallCheckFilterForJakartaServlet.java:69)
at io.undertow.servlet.core.ManagedFilter.doFilter(ManagedFilter.java:67)
at io.undertow.servlet.handlers.FilterHandler$FilterChainImpl.doFilter(FilterHandler.java:131)
at cn.dev33.satoken.filter.SaTokenCorsFilterForJakartaServlet.doFilter(SaTokenCorsFilterForJakartaServlet.java:52)
at io.undertow.servlet.core.ManagedFilter.doFilter(ManagedFilter.java:67)
at io.undertow.servlet.handlers.FilterHandler$FilterChainImpl.doFilter(FilterHandler.java:131)
at cn.dev33.satoken.filter.SaTokenContextFilterForJakartaServlet.doFilter(SaTokenContextFilterForJakartaServlet.java:40)
at io.undertow.servlet.core.ManagedFilter.doFilter(ManagedFilter.java:67)
at io.undertow.servlet.handlers.FilterHandler$FilterChainImpl.doFilter(FilterHandler.java:131)
at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:100)
at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:116)
at io.undertow.servlet.core.ManagedFilter.doFilter(ManagedFilter.java:67)
at io.undertow.servlet.handlers.FilterHandler$FilterChainImpl.doFilter(FilterHandler.java:131)
at org.springframework.web.filter.FormContentFilter.doFilterInternal(FormContentFilter.java:93)
at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:116)
at io.undertow.servlet.core.ManagedFilter.doFilter(ManagedFilter.java:67)
at io.undertow.servlet.handlers.FilterHandler$FilterChainImpl.doFilter(FilterHandler.java:131)
at com.kenzhao.smallsteps.common.web.filter.XssFilter.doFilter(XssFilter.java:38)
at io.undertow.servlet.core.ManagedFilter.doFilter(ManagedFilter.java:67)
at io.undertow.servlet.handlers.FilterHandler$FilterChainImpl.doFilter(FilterHandler.java:131)
at org.springframework.web.filter.ServerHttpObservationFilter.doFilterInternal(ServerHttpObservationFilter.java:110)
at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:116)
at io.undertow.servlet.core.ManagedFilter.doFilter(ManagedFilter.java:67)
at io.undertow.servlet.handlers.FilterHandler$FilterChainImpl.doFilter(FilterHandler.java:131)
at com.kenzhao.smallsteps.common.encrypt.filter.CryptoFilter.doFilter(CryptoFilter.java:70)
at io.undertow.servlet.core.ManagedFilter.doFilter(ManagedFilter.java:67)
at io.undertow.servlet.handlers.FilterHandler$FilterChainImpl.doFilter(FilterHandler.java:131)
at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:201)
at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:116)
at io.undertow.servlet.core.ManagedFilter.doFilter(ManagedFilter.java:67)
at io.undertow.servlet.handlers.FilterHandler$FilterChainImpl.doFilter(FilterHandler.java:131)
at io.undertow.servlet.handlers.FilterHandler.handleRequest(FilterHandler.java:84)
at io.undertow.servlet.handlers.security.ServletSecurityRoleHandler.handleRequest(ServletSecurityRoleHandler.java:62)
at io.undertow.servlet.handlers.ServletChain$1.handleRequest(ServletChain.java:68)
at io.undertow.servlet.handlers.ServletDispatchingHandler.handleRequest(ServletDispatchingHandler.java:36)
at io.undertow.servlet.handlers.RedirectDirHandler.handleRequest(RedirectDirHandler.java:68)
at io.undertow.servlet.handlers.security.SSLInformationAssociationHandler.handleRequest(SSLInformationAssociationHandler.java:117)
at io.undertow.servlet.handlers.security.ServletAuthenticationCallHandler.handleRequest(ServletAuthenticationCallHandler.java:57)
at io.undertow.server.handlers.PredicateHandler.handleRequest(PredicateHandler.java:43)
at io.undertow.security.handlers.AbstractConfidentialityHandler.handleRequest(AbstractConfidentialityHandler.java:46)
at io.undertow.servlet.handlers.security.ServletConfidentialityConstraintHandler.handleRequest(ServletConfidentialityConstraintHandler.java:64)
at io.undertow.security.handlers.AuthenticationMechanismsHandler.handleRequest(AuthenticationMechanismsHandler.java:60)
at io.undertow.servlet.handlers.security.CachedAuthenticatedSessionHandler.handleRequest(CachedAuthenticatedSessionHandler.java:75)
at io.undertow.security.handlers.AbstractSecurityContextAssociationHandler.handleRequest(AbstractSecurityContextAssociationHandler.java:43)
at io.undertow.server.handlers.PredicateHandler.handleRequest(PredicateHandler.java:43)
at io.undertow.servlet.handlers.SendErrorPageHandler.handleRequest(SendErrorPageHandler.java:52)
at io.undertow.server.handlers.PredicateHandler.handleRequest(PredicateHandler.java:43)
at io.undertow.servlet.handlers.ServletInitialHandler.handleFirstRequest(ServletInitialHandler.java:271)
at io.undertow.servlet.handlers.ServletInitialHandler$1.call(ServletInitialHandler.java:130)
at io.undertow.servlet.handlers.ServletInitialHandler$1.call(ServletInitialHandler.java:127)
at io.undertow.servlet.core.ServletRequestContextThreadSetupAction$1.call(ServletRequestContextThreadSetupAction.java:48)
at io.undertow.servlet.core.ContextClassLoaderSetupAction$1.call(ContextClassLoaderSetupAction.java:43)
at io.undertow.servlet.handlers.ServletInitialHandler.dispatchRequest(ServletInitialHandler.java:251)
at io.undertow.servlet.handlers.ServletInitialHandler.lambda$new$1(ServletInitialHandler.java:99)
at io.undertow.server.Connectors.executeRootHandler(Connectors.java:395)
at io.undertow.server.HttpServerExchange$1.run(HttpServerExchange.java:900)
at org.jboss.threads.ContextHandler$1.runWith(ContextHandler.java:18)
at org.jboss.threads.EnhancedQueueExecutor$Task.doRunWith(EnhancedQueueExecutor.java:2691)
at org.jboss.threads.EnhancedQueueExecutor$Task.run(EnhancedQueueExecutor.java:2670)
at org.jboss.threads.EnhancedQueueExecutor$ThreadBody.run(EnhancedQueueExecutor.java:1615)
at org.xnio.XnioWorker$WorkerThreadFactory$1$1.run(XnioWorker.java:1282)
at java.base/java.lang.Thread.run(Thread.java:1583)
Caused by: org.postgresql.util.PSQLException: ERROR: column "create_dept" does not exist
位置：38
at org.postgresql.core.v3.QueryExecutorImpl.receiveErrorResponse(QueryExecutorImpl.java:2736)
at org.postgresql.core.v3.QueryExecutorImpl.processResults(QueryExecutorImpl.java:2421)
at org.postgresql.core.v3.QueryExecutorImpl.execute(QueryExecutorImpl.java:372)
at org.postgresql.jdbc.PgStatement.executeInternal(PgStatement.java:525)
at org.postgresql.jdbc.PgStatement.execute(PgStatement.java:435)
at org.postgresql.jdbc.PgPreparedStatement.executeWithFlags(PgPreparedStatement.java:196)
at org.postgresql.jdbc.PgPreparedStatement.execute(PgPreparedStatement.java:182)
at com.zaxxer.hikari.pool.ProxyPreparedStatement.execute(ProxyPreparedStatement.java:44)
at com.zaxxer.hikari.pool.HikariProxyPreparedStatement.execute(HikariProxyPreparedStatement.java)
at com.p6spy.engine.wrapper.PreparedStatementWrapper.execute(PreparedStatementWrapper.java:362)
at org.apache.ibatis.executor.statement.PreparedStatementHandler.query(PreparedStatementHandler.java:65)
at org.apache.ibatis.executor.statement.RoutingStatementHandler.query(RoutingStatementHandler.java:80)
at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
at java.base/java.lang.reflect.Method.invoke(Method.java:580)
at org.apache.ibatis.plugin.Plugin.invoke(Plugin.java:61)
at jdk.proxy2/jdk.proxy2.$Proxy228.query(Unknown Source)
at org.apache.ibatis.executor.SimpleExecutor.doQuery(SimpleExecutor.java:65)
at org.apache.ibatis.executor.BaseExecutor.queryFromDatabase(BaseExecutor.java:336)
at org.apache.ibatis.executor.BaseExecutor.query(BaseExecutor.java:158)
at org.apache.ibatis.executor.CachingExecutor.query(CachingExecutor.java:110)
at com.baomidou.mybatisplus.extension.plugins.MybatisPlusInterceptor.intercept(MybatisPlusInterceptor.java:81)
at org.apache.ibatis.plugin.Plugin.invoke(Plugin.java:59)
at jdk.proxy2/jdk.proxy2.$Proxy227.query(Unknown Source)
at org.apache.ibatis.session.defaults.DefaultSqlSession.selectList(DefaultSqlSession.java:154)
at org.apache.ibatis.session.defaults.DefaultSqlSession.selectList(DefaultSqlSession.java:147)
at org.apache.ibatis.session.defaults.DefaultSqlSession.selectList(DefaultSqlSession.java:142)
at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:103)
at java.base/java.lang.reflect.Method.invoke(Method.java:580)
at org.mybatis.spring.SqlSessionTemplate$SqlSessionInterceptor.invoke(SqlSessionTemplate.java:333)
... 119 common frames omitted
2026-04-24 00:40:22 [XNIO-1 task-2] INFO  c.k.s.c.w.i.PlusWebInvokeTimeInterceptor
- [PLUS]结束请求 => URL[GET /ssapi/parent/reward/score/1002],耗时:[6]毫秒
  Consume Time：1 ms 2026-04-24 00:40:22
  Execute SQL：SELECT user_id,balance,total_earned,create_dept,create_by,create_time,update_by,update_time FROM ss_child_score WHERE (user_id = 1002)

# 6 儿童端app各项功能实现
![img_1.png](img_1.png) 

# 7 web管理后台报错
"setting" store installed 🆕
pinia.js?v=bcfdac44:4616 🍍 "user" store installed 🆕
pinia.js?v=bcfdac44:4616 🍍 "permission" store installed 🆕
vue-router.js?v=bcfdac44:207 [Vue Router warn]: uncaught error during route navigation:
warn$1 @ vue-router.js?v=bcfdac44:207了解此警告
vue-router.js?v=bcfdac44:2263 Error: Route paths should start with a "/": "ai" should be "/ai".
at tokenizePath (vue-router.js?v=bcfdac44:1274:36)
at createRouteRecordMatcher (vue-router.js?v=bcfdac44:1513:33)
at Object.addRoute (vue-router.js?v=bcfdac44:1564:17)
at Object.addRoute (vue-router.js?v=bcfdac44:2012:20)
at permission.ts:45:22
at Array.forEach (<anonymous>)
at permission.ts:43:24
triggerError @ vue-router.js?v=bcfdac44:2263了解此错误
vue-router.js?v=bcfdac44:207 [Vue Router warn]: Unexpected error when starting the router: Error: Route paths should start with a "/": "ai" should be "/ai".
at tokenizePath (vue-router.js?v=bcfdac44:1274:36)
at createRouteRecordMatcher (vue-router.js?v=bcfdac44:1513:33)
at Object.addRoute (vue-router.js?v=bcfdac44:1564:17)
at Object.addRoute (vue-router.js?v=bcfdac44:2012:20)
at permission.ts:45:22
at Array.forEach (<anonymous>)
at permission.ts:43:24