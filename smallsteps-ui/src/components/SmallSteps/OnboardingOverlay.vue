<template>
  <div v-if="visible" class="onboarding-overlay">
    <!-- Spotlight Mask -->
    <div class="spotlight-mask" :style="maskStyle"></div>

    <!-- Xiao Bu Companion -->
    <div class="xiaobu-container" :class="currentStepData.position">
      <div class="robot-wrapper">
        <img src="https://img.icons8.com/fluency/100/robot.png" class="robot-avatar" alt="Xiao Bu" />
        <div class="chat-bubble">
          <p>{{ currentStepData.text }}</p>
          <div class="actions">
            <el-button v-if="currentStep < steps.length - 1" type="primary" size="small" round @click="nextStep">下一步</el-button>
            <el-button v-else type="success" size="small" round @click="finish">开启探索</el-button>
            <el-button link size="small" @click="skip">跳过</el-button>
          </div>
        </div>
      </div>
    </div>
    
    <!-- Focus Target Indicator -->
    <div v-if="targetRect" class="focus-indicator" :style="indicatorStyle"></div>

    <!-- Confetti Celebration -->
    <div v-if="showConfetti" class="confetti-container">
      <div v-for="(dot, i) in confettiDots" :key="i" class="confetti-dot" :style="getDotStyle(i)"></div>
    </div>
  </div>
</template>

<script setup lang="ts">
// ... existing script logic
function getDotStyle(i: number) {
  const left = Math.random() * 100;
  const delay = Math.random() * 2;
  const color = ['#ff0000', '#00ff00', '#0000ff', '#ffff00', '#ff00ff'][i % 5];
  return {
    left: `${left}%`,
    animationDelay: `${delay}s`,
    backgroundColor: color
  };
}
const props = defineProps({
  modelValue: Boolean
});

const emit = defineEmits(['update:modelValue', 'complete']);

const visible = ref(false);
const currentStep = ref(0);
const targetRect = ref<DOMRect | null>(null);

const steps = [
  {
    text: "嘿！我是小步，你的 AI 行为伙伴。让我们一起开启超能力吧！",
    target: null,
    position: 'center'
  },
  {
    text: "这里是你的‘今日焦点’，我会在这里提醒你最重要的任务。",
    target: '.hero-section',
    position: 'bottom'
  },
  {
    text: "完成任务后，点击这里可以领取你的星星奖励哦！",
    target: '.stat-card:first-child',
    position: 'top'
  }
];

const currentStepData = computed(() => steps[currentStep.value]);

const maskStyle = computed(() => {
  if (!targetRect.value) return {};
  const { left, top, width, height } = targetRect.value;
  return {
    clipPath: `polygon(0% 0%, 0% 100%, ${left}px 100%, ${left}px ${top}px, ${left + width}px ${top}px, ${left + width}px ${top + height}px, ${left}px ${top + height}px, ${left}px 100%, 100% 100%, 100% 0%)`
  };
});

const indicatorStyle = computed(() => {
  if (!targetRect.value) return {};
  const { left, top, width, height } = targetRect.value;
  return {
    left: `${left - 4}px`,
    top: `${top - 4}px`,
    width: `${width + 8}px`,
    height: `${height + 8}px`
  };
});

function updateTarget() {
  const selector = currentStepData.value.target;
  if (selector) {
    const el = document.querySelector(selector);
    if (el) {
      targetRect.value = el.getBoundingClientRect();
      return;
    }
  }
  targetRect.value = null;
}

function nextStep() {
  currentStep.value++;
  updateTarget();
}

function skip() {
  finish();
}

function finish() {
  showConfetti.value = true;
  setTimeout(() => {
    visible.value = false;
    localStorage.setItem('ss_onboarding_completed', 'true');
    emit('update:modelValue', false);
    emit('complete');
  }, 2000);
}

const showConfetti = ref(false);
const confettiDots = Array.from({ length: 50 });

onMounted(() => {
  const completed = localStorage.getItem('ss_onboarding_completed');
  if (!completed) {
    visible.value = true;
    updateTarget();
  }
});

watch(() => props.modelValue, (val) => {
  if (val) {
    visible.value = true;
    currentStep.value = 0;
    updateTarget();
  }
});
</script>

<style scoped lang="scss">
.onboarding-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  z-index: 9999;
  pointer-events: none;

  .spotlight-mask {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.7);
    backdrop-filter: blur(2px);
    pointer-events: auto;
    transition: clip-path 0.3s ease-in-out;
  }

  .focus-indicator {
    position: absolute;
    border: 3px solid #FFD700;
    border-radius: 12px;
    box-shadow: 0 0 15px #FFD700;
    pointer-events: none;
    animation: pulse 2s infinite;
  }

  .xiaobu-container {
    position: absolute;
    z-index: 10000;
    pointer-events: auto;
    transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);

    &.center {
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
    }

    &.top {
      top: 100px;
      left: 50%;
      transform: translateX(-50%);
    }

    &.bottom {
      bottom: 100px;
      left: 50%;
      transform: translateX(-50%);
    }

    .robot-wrapper {
      display: flex;
      flex-direction: column;
      items-center: center;
      gap: 20px;

      .robot-avatar {
        width: 80px;
        height: 80px;
        filter: drop-shadow(0 0 10px rgba(255, 255, 255, 0.5));
        animation: float 3s ease-in-out infinite;
      }

      .chat-bubble {
        background: white;
        padding: 20px;
        border-radius: 24px;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        max-width: 300px;
        position: relative;

        p {
          margin: 0 0 15px 0;
          font-size: 16px;
          line-height: 1.5;
          color: #2c3e50;
          font-weight: 500;
        }

        .actions {
          display: flex;
          justify-content: flex-end;
          gap: 10px;
        }

        &::after {
          content: '';
          position: absolute;
          top: -10px;
          left: 50%;
          transform: translateX(-50%);
          border-left: 10px solid transparent;
          border-right: 10px solid transparent;
          border-bottom: 10px solid white;
        }
      }
    }
  }
}

@keyframes pulse {
  0% { box-shadow: 0 0 0 0 rgba(255, 215, 0, 0.7); }
  70% { box-shadow: 0 0 0 15px rgba(255, 215, 0, 0); }
  100% { box-shadow: 0 0 0 0 rgba(255, 215, 0, 0); }
}

@keyframes float {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-10px); }
}

.confetti-container {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
  overflow: hidden;
  z-index: 10001;

  .confetti-dot {
    position: absolute;
    width: 10px;
    height: 10px;
    border-radius: 50%;
    top: -20px;
    animation: fall 3s ease-in infinite;
  }
}

@keyframes fall {
  0% { transform: translateY(0) rotate(0deg); opacity: 1; }
  100% { transform: translateY(100vh) rotate(720deg); opacity: 0; }
}
</style>
