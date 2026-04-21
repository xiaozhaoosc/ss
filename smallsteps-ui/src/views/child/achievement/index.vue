<template>
  <div class="p-6 bg-[#f4f7fe] min-h-screen">
    <!-- 头部统计大卡片 -->
    <div class="bg-gradient-to-r from-blue-500 to-purple-500 rounded-[32px] p-8 text-white mb-8 shadow-lg relative overflow-hidden">
      <div class="absolute -right-10 -top-10 opacity-20">
        <el-icon class="text-[200px]"><Trophy /></el-icon>
      </div>
      <div class="relative z-10 flex flex-col md:flex-row justify-between items-center">
        <div class="flex items-center mb-6 md:mb-0">
          <div class="w-24 h-24 bg-white/20 rounded-full flex items-center justify-center backdrop-blur border-2 border-white/30 mr-6">
            <img src="@/assets/images/profile.jpg" class="w-20 h-20 rounded-full object-cover" onerror="this.src='data:image/svg+xml;utf8,<svg xmlns=\'http://www.w3.org/2000/svg\' viewBox=\'0 0 100 100\'><circle cx=\'50\' cy=\'50\' r=\'50\' fill=\'%23fff\'/><text x=\'50\' y=\'65\' font-size=\'40\' text-anchor=\'middle\' fill=\'%23409EFF\'>👦</text></svg>'" />
          </div>
          <div>
            <h1 class="text-3xl font-black mb-2 flex items-center">
              小小探险家
              <el-tag type="warning" effect="dark" round class="ml-3 !border-none bg-yellow-400 text-yellow-900 font-bold">LV.5</el-tag>
            </h1>
            <p class="text-blue-100 text-lg">你已经连续打卡 <strong class="text-yellow-300 text-2xl mx-1">{{ streakDays }}</strong> 天啦，太棒了！</p>
          </div>
        </div>
        
        <div class="flex gap-6 text-center">
          <div class="bg-white/10 backdrop-blur rounded-2xl p-4 min-w-[120px] border border-white/20">
            <div class="text-4xl font-black text-yellow-300 mb-1">{{ stars }}</div>
            <div class="text-blue-100 text-sm font-medium">累计星星</div>
          </div>
          <div class="bg-white/10 backdrop-blur rounded-2xl p-4 min-w-[120px] border border-white/20">
            <div class="text-4xl font-black text-cyan-300 mb-1">{{ fragments }}</div>
            <div class="text-blue-100 text-sm font-medium">勇气碎片</div>
          </div>
        </div>
      </div>
    </div>

    <!-- 成就勋章墙 -->
    <div class="text-2xl font-bold mb-6 text-gray-800 flex items-center">
      <el-icon class="mr-2 text-purple-500"><Medal /></el-icon>
      我的勋章墙
    </div>

    <el-card class="!border-none shadow-sm rounded-[24px] mb-8">
      <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-6 gap-6 p-4">
        <div v-for="(medal, index) in medals" :key="index" class="flex flex-col items-center group cursor-pointer">
          <div class="w-24 h-24 rounded-full flex items-center justify-center mb-3 transition-transform duration-300 group-hover:scale-110 shadow-md"
               :class="medal.unlocked ? 'bg-gradient-to-br from-yellow-200 to-yellow-400' : 'bg-gray-200 grayscale'">
            <span class="text-5xl">{{ medal.icon }}</span>
          </div>
          <div class="font-bold text-gray-800 text-center">{{ medal.name }}</div>
          <div class="text-xs text-gray-400 text-center mt-1">{{ medal.desc }}</div>
        </div>
      </div>
    </el-card>
  </div>
</template>

<script setup name="ChildAchievement" lang="ts">
import { ref, onMounted } from 'vue';
import { totalStars, totalCourageFragments, streak } from "@/api/child/achievement";
import { Trophy, Medal } from '@element-plus/icons-vue';

const childId = 1; // Demo mock ID
const stars = ref(0);
const fragments = ref(0);
const streakDays = ref(0);

const medals = ref([
  { name: '早起鸟儿', desc: '连续7天7点前起床', icon: '🐦', unlocked: true },
  { name: '专注大师', desc: '完成50次专注任务', icon: '🧘', unlocked: true },
  { name: '阅读之星', desc: '累计阅读10本书', icon: '📖', unlocked: true },
  { name: '运动小将', desc: '运动打卡30次', icon: '🏃', unlocked: false },
  { name: '家务能手', desc: '帮妈妈做10次家务', icon: '🧹', unlocked: false },
  { name: '完美一周', desc: '一周任务全部完成', icon: '🌟', unlocked: false },
]);

function loadData() {
  totalStars(childId).then(res => { stars.value = res.data || 128; }).catch(() => stars.value = 128);
  totalCourageFragments(childId).then(res => { fragments.value = res.data || 45; }).catch(() => fragments.value = 45);
  streak(childId).then(res => { streakDays.value = res.data || 12; }).catch(() => streakDays.value = 12);
}

onMounted(() => {
  loadData();
});
</script>

<style scoped>
</style>
