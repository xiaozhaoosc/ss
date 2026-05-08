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
            '/ssapi': {
                target: 'http://localhost:8081/ssapi',
                changeOrigin: true,
                rewrite: (path) => path.replace(/^\/ssapi/, '')
            }
        }
    },
    css: {
        preprocessorOptions: {
            scss: {
                api: 'modern',
                additionalData: '@import "@/uni.scss";',
                silenceDeprecations: ['legacy-js-api']
            }
        }
    }
})
