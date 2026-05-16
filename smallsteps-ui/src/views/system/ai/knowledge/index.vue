<template>
  <div class="app-container">
    <h2>Knowledge Base Management</h2>
    <el-button type="primary" @click="handleAdd">Add Knowledge</el-button>
    
    <el-table :data="knowledgeList" style="width: 100%; margin-top: 20px;">
      <el-table-column prop="title" label="Title" />
      <el-table-column prop="keywords" label="Keywords" />
      <el-table-column label="Actions">
        <template #default="scope">
          <el-button size="small" @click="handleSync(scope.row.id)">Sync to Vector</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'

const knowledgeList = ref([])

const fetchList = async () => {
  const res = await fetch('/dev-api/system/ai/knowledge/list')
  knowledgeList.value = await res.json()
}

const handleAdd = () => {
  // Simplified for plan (would open a dialog)
  console.log("Add new rule")
}

const handleSync = async (id) => {
  await fetch(`/dev-api/system/ai/knowledge/${id}/sync`, { method: 'POST' })
  alert('Synced successfully')
}

onMounted(() => {
  fetchList()
})
</script>
