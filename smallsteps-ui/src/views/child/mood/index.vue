<template>
  <div class="p-6 bg-[#f9fafe] min-h-screen flex flex-col md:flex-row gap-6">
    <!-- 左侧：心情打卡区 -->
    <div class="w-full md:w-1/3">
      <el-card class="!border-none shadow-md rounded-[32px] h-full text-center relative overflow-hidden">
        <div class="absolute -top-10 -right-10 w-40 h-40 bg-blue-50 rounded-full mix-blend-multiply filter blur-2xl opacity-70"></div>
        <div class="absolute -bottom-10 -left-10 w-40 h-40 bg-pink-50 rounded-full mix-blend-multiply filter blur-2xl opacity-70"></div>
        
        <h2 class="text-2xl font-black text-gray-800 mt-6 mb-2 relative z-10">你今天心情怎么样？</h2>
        <p class="text-gray-500 mb-8 relative z-10">记录你的心情，AI 朋友会陪伴你哦！</p>

        <div class="grid grid-cols-2 gap-4 mb-8 relative z-10 p-4">
          <div v-for="(mood, index) in moods" :key="index" 
               class="bg-white border-2 rounded-2xl p-4 cursor-pointer transition-all duration-300 hover:-translate-y-1 hover:shadow-lg"
               :class="currentMood === mood.type ? 'border-' + mood.color + '-400 shadow-md scale-105' : 'border-gray-100'"
               @click="selectMood(mood.type, mood.value)">
            <div class="text-5xl mb-2">{{ mood.icon }}</div>
            <div class="font-bold text-gray-700">{{ mood.label }}</div>
          </div>
        </div>

        <el-button type="primary" size="large" round class="w-full h-14 text-lg font-bold shadow-lg" @click="submitMood" :loading="submitting">
          记录今天的心情
        </el-button>
      </el-card>
    </div>

    <!-- 右侧：AI 伙伴聊天区 -->
    <div class="w-full md:w-2/3 flex flex-col">
      <el-card class="!border-none shadow-md rounded-[32px] flex-1 flex flex-col h-[600px] md:h-auto overflow-hidden">
        <template #header>
          <div class="flex items-center font-bold text-lg">
            <div class="w-10 h-10 bg-blue-100 rounded-full flex items-center justify-center mr-3">
              <span class="text-2xl">🤖</span>
            </div>
            <span>小步AI好朋友</span>
          </div>
        </template>

        <div class="flex-1 overflow-y-auto p-4 bg-gray-50/50 rounded-2xl mb-4 space-y-4" ref="chatBox">
          <div v-for="(msg, index) in chatHistory" :key="index" class="flex" :class="msg.role === 'user' ? 'justify-end' : 'justify-start'">
            <div v-if="msg.role === 'ai'" class="w-8 h-8 rounded-full bg-blue-100 flex items-center justify-center mr-2 shrink-0">🤖</div>
            <div class="max-w-[75%] p-3 rounded-2xl text-sm leading-relaxed" 
                 :class="msg.role === 'user' ? 'bg-blue-500 text-white rounded-tr-none shadow-sm' : 'bg-white text-gray-800 border border-gray-100 rounded-tl-none shadow-sm'">
              {{ msg.content }}
            </div>
            <div v-if="msg.role === 'user'" class="w-8 h-8 rounded-full bg-orange-100 flex items-center justify-center ml-2 shrink-0">👦</div>
          </div>
          <div v-if="aiTyping" class="flex justify-start">
            <div class="w-8 h-8 rounded-full bg-blue-100 flex items-center justify-center mr-2 shrink-0">🤖</div>
            <div class="bg-white border border-gray-100 p-3 rounded-2xl rounded-tl-none shadow-sm flex items-center space-x-1">
              <div class="w-2 h-2 bg-gray-400 rounded-full animate-bounce"></div>
              <div class="w-2 h-2 bg-gray-400 rounded-full animate-bounce" style="animation-delay: 0.1s"></div>
              <div class="w-2 h-2 bg-gray-400 rounded-full animate-bounce" style="animation-delay: 0.2s"></div>
            </div>
          </div>
        </div>

        <div class="flex gap-3">
          <el-input v-model="inputText" placeholder="和小步AI分享你的想法吧..." class="!text-lg" size="large" @keyup.enter="sendMessage">
            <template #prefix>
              <el-icon><EditPen /></el-icon>
            </template>
          </el-input>
          <el-button type="primary" size="large" round class="px-8 shadow-md" @click="sendMessage" :disabled="!inputText.trim() || aiTyping">
            <el-icon class="mr-1"><Position /></el-icon> 发送
          </el-button>
        </div>
      </el-card>
    </div>
  </div>
</template>

<script setup name="ChildMood" lang="ts">
import { ref, reactive, nextTick, getCurrentInstance, ComponentInternalInstance } from 'vue';
import { EditPen, Position } from '@element-plus/icons-vue';
import request from '@/utils/request';

const { proxy } = getCurrentInstance() as ComponentInternalInstance;
const childId = 1;

const moods = [
  { type: 'happy', value: 5, label: '很开心', icon: '😄', color: 'green' },
  { type: 'calm', value: 4, label: '很平静', icon: '😌', color: 'blue' },
  { type: 'sad', value: 2, label: '有点难过', icon: '😢', color: 'indigo' },
  { type: 'angry', value: 3, label: '有点生气', icon: '😠', color: 'red' },
];

const currentMood = ref('');
const currentMoodValue = ref(4);
const submitting = ref(false);

const inputText = ref('');
const aiTyping = ref(false);
const chatBox = ref<HTMLElement | null>(null);

const chatHistory = ref([
  { role: 'ai', content: '你好呀！我是小步AI好朋友，今天过得怎么样呢？有没有什么有趣的事情想和我分享？' }
]);

function selectMood(type: string, value: number) {
  currentMood.value = type;
  currentMoodValue.value = value;
}

function submitMood() {
  if (!currentMood.value) {
    proxy?.$modal.msgWarning("请先选择一个心情哦！");
    return;
  }
  submitting.value = true;
  // 调用后端记录情绪接口，这里模拟一下
  setTimeout(() => {
    submitting.value = false;
    proxy?.$modal.msgSuccess("心情记录成功！");
    
    // 如果情绪低落，AI 自动关怀
    if (currentMoodValue.value < 4) {
      chatHistory.value.push({ role: 'ai', content: '我注意到你今天的心情似乎不太好。深呼吸，你想和我聊聊发生了什么事吗？我会一直在你身边的。' });
      scrollToBottom();
    } else {
      chatHistory.value.push({ role: 'ai', content: '看到你今天心情不错，我也很开心！继续保持哦！🌟' });
      scrollToBottom();
    }
  }, 800);
}

function sendMessage() {
  if (!inputText.value.trim() || aiTyping.value) return;
  
  const text = inputText.value;
  chatHistory.value.push({ role: 'user', content: text });
  inputText.value = '';
  scrollToBottom();
  
  aiTyping.value = true;
  
  // 调用AI对话接口
  request({
    url: '/child/ai/chat',
    method: 'post',
    params: { childId, userInput: text, emotionType: currentMoodValue.value }
  }).then((res: any) => {
    aiTyping.value = false;
    chatHistory.value.push({ role: 'ai', content: res.msg || res.data || '收到你的消息啦！' });
    scrollToBottom();
  }).catch(() => {
    aiTyping.value = false;
    // 模拟回复
    setTimeout(() => {
      chatHistory.value.push({ role: 'ai', content: '这是一个模拟回复：我明白你的感受。你可以再多跟我说一点吗？' });
      scrollToBottom();
    }, 1000);
  });
}

function scrollToBottom() {
  nextTick(() => {
    if (chatBox.value) {
      chatBox.value.scrollTop = chatBox.value.scrollHeight;
    }
  });
}
</script>

<style scoped>
/* 隐藏滚动条 */
.overflow-y-auto::-webkit-scrollbar {
  width: 6px;
}
.overflow-y-auto::-webkit-scrollbar-thumb {
  background: #e5e7eb;
  border-radius: 10px;
}
.overflow-y-auto::-webkit-scrollbar-track {
  background: transparent;
}
</style>
