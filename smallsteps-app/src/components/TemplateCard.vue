<template>
  <view class="bg-white rounded-lg shadow-sm overflow-hidden flex flex-col" @click="onClick">
    <view class="h-32 w-full flex items-center justify-center text-4xl" :style="{ backgroundColor: bgColor }">
      {{ icon }}
    </view>
    <view class="p-3 flex-1 flex flex-col justify-between">
      <view>
        <text class="text-base font-bold text-gray-800 line-clamp-2">{{ title }}</text>
        <view class="flex flex-wrap gap-1 mt-2">
          <text v-for="(tag, index) in tags" :key="index" class="text-xs px-2 py-0.5 bg-gray-100 text-gray-600 rounded-full">
            {{ tag }}
          </text>
        </view>
      </view>
      <text class="text-xs text-gray-400 mt-3">{{ stepCount }} 个步骤</text>
    </view>
  </view>
</template>

<script setup lang="ts">
const props = defineProps({
  id: {
    type: [String, Number],
    required: true
  },
  title: {
    type: String,
    required: true
  },
  bgColor: {
    type: String,
    default: '#e0e7ff'
  },
  icon: {
    type: String,
    default: '📝'
  },
  tags: {
    type: Array as () => string[],
    default: () => []
  },
  stepCount: {
    type: Number,
    default: 0
  }
})

const emit = defineEmits(['click'])

const onClick = () => {
  emit('click', props.id)
}
</script>