# Instructions

- Following Playwright test failed.
- Explain why, be concise, respect Playwright best practices.
- Provide a snippet of code with the fix, if possible.

# Test info

- Name: spec\parent-full.spec.ts >> Parent Full E2E Flow Tests >> Complete parent workflow
- Location: tests\e2e\spec\parent-full.spec.ts:24:7

# Error details

```
Test timeout of 30000ms exceeded.
```

```
Error: locator.click: Test timeout of 30000ms exceeded.
Call log:
  - waiting for getByText('任务')
    - locator resolved to <div class="uni-tabbar__label">任务</div>
  - attempting click action
    2 × waiting for element to be visible, enabled and stable
      - element is not visible
    - retrying click action
    - waiting 20ms
    2 × waiting for element to be visible, enabled and stable
      - element is not visible
    - retrying click action
      - waiting 100ms
    58 × waiting for element to be visible, enabled and stable
       - element is not visible
     - retrying click action
       - waiting 500ms

```

# Page snapshot

```yaml
- generic [ref=e7]:
  - generic [ref=e8]:
    - generic [ref=e10]: arrow_back_ios
    - generic [ref=e11]: 执行记录
  - generic [ref=e16]:
    - generic [ref=e17]:
      - generic [ref=e18]:
        - generic [ref=e19]:
          - generic [ref=e21]: task
          - generic [ref=e22]:
            - generic [ref=e23]: 数学作业
            - generic [ref=e24]: 04-24 20:24
        - generic [ref=e25]: 已完成
      - generic [ref=e27]:
        - generic [ref=e28]: "预计完成日期:"
        - generic [ref=e29]: "-"
      - generic [ref=e31] [cursor=pointer]:
        - generic [ref=e32]: delete
        - generic [ref=e33]: 删除
    - generic [ref=e34]:
      - generic [ref=e35]:
        - generic [ref=e36]:
          - generic [ref=e38]: task
          - generic [ref=e39]:
            - generic [ref=e40]: 阅读30分钟
            - generic [ref=e41]: 04-20 20:24
        - generic [ref=e42]: 已完成
      - generic [ref=e44]:
        - generic [ref=e45]: "预计完成日期:"
        - generic [ref=e46]: "-"
      - generic [ref=e48] [cursor=pointer]:
        - generic [ref=e49]: delete
        - generic [ref=e50]: 删除
    - generic [ref=e51]:
      - generic [ref=e52]:
        - generic [ref=e53]:
          - generic [ref=e55]: task
          - generic [ref=e56]:
            - generic [ref=e57]: 数学作业
            - generic [ref=e58]: 04-19 20:24
        - generic [ref=e59]: 已完成
      - generic [ref=e61]:
        - generic [ref=e62]: "预计完成日期:"
        - generic [ref=e63]: "-"
      - generic [ref=e65] [cursor=pointer]:
        - generic [ref=e66]: delete
        - generic [ref=e67]: 删除
    - generic [ref=e68]:
      - generic [ref=e69]:
        - generic [ref=e70]:
          - generic [ref=e72]: task
          - generic [ref=e73]:
            - generic [ref=e74]: 早起刷牙
            - generic [ref=e75]: 04-18 20:24
        - generic [ref=e76]: 已完成
      - generic [ref=e78]:
        - generic [ref=e79]: "预计完成日期:"
        - generic [ref=e80]: "-"
      - generic [ref=e82] [cursor=pointer]:
        - generic [ref=e83]: delete
        - generic [ref=e84]: 删除
    - generic [ref=e85]:
      - generic [ref=e86]:
        - generic [ref=e87]:
          - generic [ref=e89]: task
          - generic [ref=e90]:
            - generic [ref=e91]: 数学作业
            - generic [ref=e92]: 04-17 20:24
        - generic [ref=e93]: 已完成
      - generic [ref=e95]:
        - generic [ref=e96]: "预计完成日期:"
        - generic [ref=e97]: "-"
      - generic [ref=e99] [cursor=pointer]:
        - generic [ref=e100]: delete
        - generic [ref=e101]: 删除
    - generic [ref=e102]:
      - generic [ref=e103]:
        - generic [ref=e104]:
          - generic [ref=e106]: task
          - generic [ref=e107]:
            - generic [ref=e108]: 数学作业
            - generic [ref=e109]: 04-16 20:24
        - generic [ref=e110]: 已完成
      - generic [ref=e112]:
        - generic [ref=e113]: "预计完成日期:"
        - generic [ref=e114]: "-"
      - generic [ref=e116] [cursor=pointer]:
        - generic [ref=e117]: delete
        - generic [ref=e118]: 删除
    - generic [ref=e119]:
      - generic [ref=e120]:
        - generic [ref=e121]:
          - generic [ref=e123]: task
          - generic [ref=e124]:
            - generic [ref=e125]: 早起刷牙
            - generic [ref=e126]: 04-15 20:24
        - generic [ref=e127]: 已完成
      - generic [ref=e129]:
        - generic [ref=e130]: "预计完成日期:"
        - generic [ref=e131]: "-"
      - generic [ref=e133] [cursor=pointer]:
        - generic [ref=e134]: delete
        - generic [ref=e135]: 删除
    - generic [ref=e136]:
      - generic [ref=e137]:
        - generic [ref=e138]:
          - generic [ref=e140]: task
          - generic [ref=e141]:
            - generic [ref=e142]: 数学作业
            - generic [ref=e143]: 04-12 20:24
        - generic [ref=e144]: 已完成
      - generic [ref=e146]:
        - generic [ref=e147]: "预计完成日期:"
        - generic [ref=e148]: "-"
      - generic [ref=e150] [cursor=pointer]:
        - generic [ref=e151]: delete
        - generic [ref=e152]: 删除
    - generic [ref=e153]:
      - generic [ref=e154]:
        - generic [ref=e155]:
          - generic [ref=e157]: task
          - generic [ref=e158]:
            - generic [ref=e159]: 数学作业
            - generic [ref=e160]: 04-11 20:24
        - generic [ref=e161]: 已完成
      - generic [ref=e163]:
        - generic [ref=e164]: "预计完成日期:"
        - generic [ref=e165]: "-"
      - generic [ref=e167] [cursor=pointer]:
        - generic [ref=e168]: delete
        - generic [ref=e169]: 删除
    - generic [ref=e170]:
      - generic [ref=e171]:
        - generic [ref=e172]:
          - generic [ref=e174]: task
          - generic [ref=e175]:
            - generic [ref=e176]: 早起刷牙
            - generic [ref=e177]: 04-10 20:24
        - generic [ref=e178]: 已完成
      - generic [ref=e180]:
        - generic [ref=e181]: "预计完成日期:"
        - generic [ref=e182]: "-"
      - generic [ref=e184] [cursor=pointer]:
        - generic [ref=e185]: delete
        - generic [ref=e186]: 删除
    - generic [ref=e187]:
      - generic [ref=e188]:
        - generic [ref=e189]:
          - generic [ref=e191]: task
          - generic [ref=e192]:
            - generic [ref=e193]: 数学作业
            - generic [ref=e194]: 04-09 20:24
        - generic [ref=e195]: 已完成
      - generic [ref=e197]:
        - generic [ref=e198]: "预计完成日期:"
        - generic [ref=e199]: "-"
      - generic [ref=e201] [cursor=pointer]:
        - generic [ref=e202]: delete
        - generic [ref=e203]: 删除
    - generic [ref=e204]:
      - generic [ref=e205]:
        - generic [ref=e206]:
          - generic [ref=e208]: task
          - generic [ref=e209]:
            - generic [ref=e210]: 早起刷牙
            - generic [ref=e211]: 04-08 20:24
        - generic [ref=e212]: 已完成
      - generic [ref=e214]:
        - generic [ref=e215]: "预计完成日期:"
        - generic [ref=e216]: "-"
      - generic [ref=e218] [cursor=pointer]:
        - generic [ref=e219]: delete
        - generic [ref=e220]: 删除
    - generic [ref=e221]:
      - generic [ref=e222]:
        - generic [ref=e223]:
          - generic [ref=e225]: task
          - generic [ref=e226]:
            - generic [ref=e227]: 整理房间
            - generic [ref=e228]: 04-06 20:24
        - generic [ref=e229]: 已完成
      - generic [ref=e231]:
        - generic [ref=e232]: "预计完成日期:"
        - generic [ref=e233]: "-"
      - generic [ref=e235] [cursor=pointer]:
        - generic [ref=e236]: delete
        - generic [ref=e237]: 删除
    - generic [ref=e238]:
      - generic [ref=e239]:
        - generic [ref=e240]:
          - generic [ref=e242]: task
          - generic [ref=e243]:
            - generic [ref=e244]: 整理房间
            - generic [ref=e245]: 04-05 20:24
        - generic [ref=e246]: 已完成
      - generic [ref=e248]:
        - generic [ref=e249]: "预计完成日期:"
        - generic [ref=e250]: "-"
      - generic [ref=e252] [cursor=pointer]:
        - generic [ref=e253]: delete
        - generic [ref=e254]: 删除
    - generic [ref=e255]:
      - generic [ref=e256]:
        - generic [ref=e257]:
          - generic [ref=e259]: task
          - generic [ref=e260]:
            - generic [ref=e261]: 数学作业
            - generic [ref=e262]: 04-03 20:24
        - generic [ref=e263]: 已完成
      - generic [ref=e265]:
        - generic [ref=e266]: "预计完成日期:"
        - generic [ref=e267]: "-"
      - generic [ref=e269] [cursor=pointer]:
        - generic [ref=e270]: delete
        - generic [ref=e271]: 删除
    - generic [ref=e272]:
      - generic [ref=e273]:
        - generic [ref=e274]:
          - generic [ref=e276]: task
          - generic [ref=e277]:
            - generic [ref=e278]: 数学作业
            - generic [ref=e279]: 04-02 20:24
        - generic [ref=e280]: 已完成
      - generic [ref=e282]:
        - generic [ref=e283]: "预计完成日期:"
        - generic [ref=e284]: "-"
      - generic [ref=e286] [cursor=pointer]:
        - generic [ref=e287]: delete
        - generic [ref=e288]: 删除
    - generic [ref=e289]:
      - generic [ref=e290]:
        - generic [ref=e291]:
          - generic [ref=e293]: task
          - generic [ref=e294]:
            - generic [ref=e295]: 数学作业
            - generic [ref=e296]: 04-01 20:24
        - generic [ref=e297]: 已完成
      - generic [ref=e299]:
        - generic [ref=e300]: "预计完成日期:"
        - generic [ref=e301]: "-"
      - generic [ref=e303] [cursor=pointer]:
        - generic [ref=e304]: delete
        - generic [ref=e305]: 删除
    - generic [ref=e306]:
      - generic [ref=e307]:
        - generic [ref=e308]:
          - generic [ref=e310]: task
          - generic [ref=e311]:
            - generic [ref=e312]: 早起刷牙
            - generic [ref=e313]: 03-31 20:24
        - generic [ref=e314]: 已完成
      - generic [ref=e316]:
        - generic [ref=e317]: "预计完成日期:"
        - generic [ref=e318]: "-"
      - generic [ref=e320] [cursor=pointer]:
        - generic [ref=e321]: delete
        - generic [ref=e322]: 删除
    - generic [ref=e323]:
      - generic [ref=e324]:
        - generic [ref=e325]:
          - generic [ref=e327]: task
          - generic [ref=e328]:
            - generic [ref=e329]: 阅读30分钟
            - generic [ref=e330]: 03-30 20:24
        - generic [ref=e331]: 已完成
      - generic [ref=e333]:
        - generic [ref=e334]: "预计完成日期:"
        - generic [ref=e335]: "-"
      - generic [ref=e337] [cursor=pointer]:
        - generic [ref=e338]: delete
        - generic [ref=e339]: 删除
    - generic [ref=e340]:
      - generic [ref=e341]:
        - generic [ref=e342]:
          - generic [ref=e344]: task
          - generic [ref=e345]:
            - generic [ref=e346]: 阅读30分钟
            - generic [ref=e347]: 03-29 20:24
        - generic [ref=e348]: 已完成
      - generic [ref=e350]:
        - generic [ref=e351]: "预计完成日期:"
        - generic [ref=e352]: "-"
      - generic [ref=e354] [cursor=pointer]:
        - generic [ref=e355]: delete
        - generic [ref=e356]: 删除
    - generic [ref=e357]:
      - generic [ref=e358]:
        - generic [ref=e359]:
          - generic [ref=e361]: task
          - generic [ref=e362]:
            - generic [ref=e363]: 早起刷牙
            - generic [ref=e364]: 03-28 20:24
        - generic [ref=e365]: 已完成
      - generic [ref=e367]:
        - generic [ref=e368]: "预计完成日期:"
        - generic [ref=e369]: "-"
      - generic [ref=e371] [cursor=pointer]:
        - generic [ref=e372]: delete
        - generic [ref=e373]: 删除
    - generic [ref=e374]:
      - generic [ref=e375]:
        - generic [ref=e376]:
          - generic [ref=e378]: task
          - generic [ref=e379]:
            - generic [ref=e380]: 数学作业
            - generic [ref=e381]: 03-27 20:24
        - generic [ref=e382]: 已完成
      - generic [ref=e384]:
        - generic [ref=e385]: "预计完成日期:"
        - generic [ref=e386]: "-"
      - generic [ref=e388] [cursor=pointer]:
        - generic [ref=e389]: delete
        - generic [ref=e390]: 删除
    - generic [ref=e391]:
      - generic [ref=e392]:
        - generic [ref=e393]:
          - generic [ref=e395]: task
          - generic [ref=e396]:
            - generic [ref=e397]: 早起刷牙
            - generic [ref=e398]: 03-26 20:24
        - generic [ref=e399]: 已完成
      - generic [ref=e401]:
        - generic [ref=e402]: "预计完成日期:"
        - generic [ref=e403]: "-"
      - generic [ref=e405] [cursor=pointer]:
        - generic [ref=e406]: delete
        - generic [ref=e407]: 删除
```

# Test source

```ts
  1  | import { Page, Locator } from '@playwright/test';
  2  | 
  3  | export class ParentNavPage {
  4  |   readonly page: Page;
  5  |   readonly homeTab: Locator;
  6  |   readonly taskTab: Locator;
  7  |   readonly insightsTab: Locator;
  8  |   readonly profileTab: Locator;
  9  | 
  10 |   constructor(page: Page) {
  11 |     this.page = page;
  12 |     this.homeTab = page.getByText('首页');
  13 |     this.taskTab = page.getByText('任务');
  14 |     this.insightsTab = page.getByText('洞察');
  15 |     this.profileTab = page.getByText('我的');
  16 |   }
  17 | 
  18 |   async goToHome() {
  19 |     await this.homeTab.click();
  20 |   }
  21 | 
  22 |   async goToTaskCreator() {
> 23 |     await this.taskTab.click();
     |                        ^ Error: locator.click: Test timeout of 30000ms exceeded.
  24 |   }
  25 | 
  26 |   async goToInsights() {
  27 |     await this.insightsTab.click();
  28 |   }
  29 | 
  30 |   async goToProfile() {
  31 |     await this.profileTab.click();
  32 |   }
  33 | }
  34 | 
```