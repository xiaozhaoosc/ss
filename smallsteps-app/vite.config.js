import { defineConfig } from 'vite'
import uni from '@dcloudio/vite-plugin-uni'
import { UnifiedViteWeappTailwindcssPlugin as weappTailwindcss } from 'weapp-tailwindcss/vite'

export default defineConfig({
    plugins: [
        uni(),
        weappTailwindcss()
    ],
    server: {
        port: 9090,
        host: '0.0.0.0',
        proxy: {
            '/dev-api': {
                target: 'http://192.168.1.9:8098',
                changeOrigin: true,
                rewrite: (path) => path.replace(/^\/dev-api/, '/ssapi')
            }
        }
    },
    css: {
        preprocessorOptions: {
            scss: {
                api: 'modern',
                additionalData: '@import "@/uni.scss";',
                silenceDeprecations: ['import-message', 'import', 'legacy-js-api']
            }
        }
    }
})
