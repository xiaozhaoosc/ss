<template>
  <div class="p-6 bg-[#fdfaf6] min-h-screen">
    <!-- 头部：我的星星 -->
    <div class="mb-8 flex items-center justify-between bg-white p-6 rounded-3xl shadow-sm border border-yellow-100">
      <div class="flex items-center">
        <div class="w-16 h-16 bg-yellow-100 rounded-full flex items-center justify-center mr-4 shadow-inner">
          <el-icon class="text-4xl text-yellow-500"><StarFilled /></el-icon>
        </div>
        <div>
          <div class="text-gray-500 font-medium">我的可用星星</div>
          <div class="text-4xl font-black text-yellow-500">{{ myStars }} <span class="text-lg text-gray-400 font-normal">颗</span></div>
        </div>
      </div>
      <div class="text-right">
        <el-button type="warning" round size="large" class="font-bold shadow-md" @click="getStars">
          <el-icon class="mr-1"><Refresh /></el-icon> 刷新星星
        </el-button>
      </div>
    </div>

    <div class="text-2xl font-bold mb-6 text-gray-800 flex items-center">
      <el-icon class="mr-2 text-orange-500"><Present /></el-icon>
      奖励兑换中心
    </div>

    <!-- 奖励列表 -->
    <el-row :gutter="24" v-loading="loading">
      <el-col v-for="item in rewardList" :key="item.rewardId" :xs="24" :sm="12" :md="8" :lg="6" class="mb-6">
        <el-card :body-style="{ padding: '0px' }" class="reward-card hover:-translate-y-2 transition-transform duration-300 !border-none shadow-md overflow-hidden rounded-[24px]">
          <div class="h-40 bg-gradient-to-br from-orange-100 to-pink-100 flex items-center justify-center relative">
            <span class="text-6xl">{{ getRewardIcon(item.rewardName) }}</span>
            <div class="absolute top-3 right-3 bg-white/80 backdrop-blur px-3 py-1 rounded-full text-sm font-bold text-orange-500 flex items-center shadow-sm">
              <el-icon class="mr-1"><StarFilled /></el-icon> {{ item.costScore || item.costStars || 10 }} 星星
            </div>
          </div>
          <div class="p-5">
            <div class="text-xl font-bold mb-2 text-gray-800">{{ item.rewardName }}</div>
            <div class="text-gray-500 text-sm mb-5 h-10 line-clamp-2">{{ item.description || '这是一个神秘的奖励，快来兑换吧！' }}</div>
            
            <el-button 
              :type="myStars >= (item.costScore || item.costStars || 10) ? 'primary' : 'info'" 
              size="large" 
              class="w-full font-bold rounded-xl h-12 text-lg shadow-sm"
              :disabled="myStars < (item.costScore || item.costStars || 10)"
              @click="handleExchange(item)"
            >
              {{ myStars >= (item.costScore || item.costStars || 10) ? '立即兑换' : '星星不够哦' }}
            </el-button>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 空状态 -->
    <el-empty v-if="!loading && rewardList.length === 0" description="暂时没有可兑换的奖励呢" />
  </div>
</template>

<script setup name="ChildReward" lang="ts">
import { ref, onMounted, getCurrentInstance, ComponentInternalInstance } from 'vue';
import { listReward } from "@/api/smallsteps/reward";
import { totalStars, exchangeReward } from "@/api/child/achievement";
import { StarFilled, Present, Refresh } from '@element-plus/icons-vue';

const { proxy } = getCurrentInstance() as ComponentInternalInstance;

const rewardList = ref<any[]>([]);
const loading = ref(true);
const myStars = ref(0);
const childId = 1; // Demo mock ID

function getStars() {
  totalStars(childId).then((res: any) => {
    myStars.value = res.data || 0;
  }).catch(() => {
    myStars.value = 50; // Mock fallback
  });
}

function getList() {
  loading.value = true;
  listReward({}).then((res: any) => {
    rewardList.value = res.rows || res.data || [
      { rewardId: 1, rewardName: '游乐场门票', description: '周末去游乐场玩一整天！', costScore: 100 },
      { rewardId: 2, rewardName: '买新玩具', description: '可以在超市挑选一个自己喜欢的玩具。', costScore: 50 },
      { rewardId: 3, rewardName: '看一场电影', description: '和爸爸妈妈一起去电影院看电影。', costScore: 30 },
      { rewardId: 4, rewardName: '吃冰淇淋', description: '美味的巧克力香草冰淇淋。', costScore: 10 }
    ];
    loading.value = false;
  }).catch(() => {
    // 接口不通时使用默认数据
    rewardList.value = [
      { rewardId: 1, rewardName: '游乐场门票', description: '周末去游乐场玩一整天！', costScore: 100 },
      { rewardId: 2, rewardName: '买新玩具', description: '可以在超市挑选一个自己喜欢的玩具。', costScore: 50 },
      { rewardId: 3, rewardName: '看一场电影', description: '和爸爸妈妈一起去电影院看电影。', costScore: 30 },
      { rewardId: 4, rewardName: '吃冰淇淋', description: '美味的巧克力香草冰淇淋。', costScore: 10 }
    ];
    loading.value = false;
  });
}

function handleExchange(item: any) {
  const cost = item.costScore || item.costStars || 10;
  proxy?.$modal.confirm('确定要花费 ' + cost + ' 颗星星兑换【' + item.rewardName + '】吗？').then(function() {
    return exchangeReward(childId, cost, item.rewardName);
  }).then(() => {
    proxy?.$modal.msgSuccess("兑换成功！请等待家长确认~");
    getStars();
  }).catch(() => {
    // 忽略取消
  });
}

function getRewardIcon(name: string) {
  if (name.includes('游乐场')) return '🎡';
  if (name.includes('玩具')) return '🧸';
  if (name.includes('电影')) return '🎬';
  if (name.includes('吃') || name.includes('冰淇淋')) return '🍦';
  if (name.includes('游戏')) return '🎮';
  return '🎁';
}

onMounted(() => {
  getStars();
  getList();
});
</script>

<style scoped>
.reward-card {
  border-radius: 24px;
}
</style>
