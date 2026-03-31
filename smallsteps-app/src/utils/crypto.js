import JSEncrypt from 'jsencrypt'
import CryptoJS from 'crypto-js'

// 后端 RSA 公钥（用于加密 AES 密钥）- 从 application.yml 获取
// 对应前端加密公钥 MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAKoR8mX0rGKLqzcWmOzbfj64K8ZIgOdHnzkXSOVOZbFu/TJhZ7rFAN+eaGkl3C4buccQd/EjEsj9ir7ijT7h96MCAwEAAQ==
const PUBLIC_KEY = 'MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBAKoR8mX0rGKLqzcWmOzbfj64K8ZIgOdHnzkXSOVOZbFu/TJhZ7rFAN+eaGkl3C4buccQd/EjEsj9ir7ijT7h96MCAwEAAQ=='

// 后端 RSA 私钥（用于解密响应）- 从 application.yml 获取  
// 对应前端解密私钥 MIIBVAIBADANBgkqhkiG9w0BAQEFAASCAT4wggE6AgEAAkEAmc3CuPiGL/LcIIm7zryCEIbl1SPzBkr75E2VMtxegyZ1lYRD+7TZGAPkvIsBcaMs6Nsy0L78n2qh+lIZMpLH8wIDAQABAkEAk82Mhz0tlv6IVCyIcw/s3f0E+WLmtPFyR9/WtV3Y5aaejUkU60JpX4m5xNR2VaqOLTZAYjW8Wy0aXr3zYIhhQQIhAMfqR9oFdYw1J9SsNc+CrhugAvKTi0+BF6VoL6psWhvbAiEAxPPNTmrkmrXwdm/pQQu3UOQmc2vCZ5tiKpW10CgJi8kCIFGkL6utxw93Ncj4exE/gPLvKcT+1Emnoox+O9kRXss5AiAMtYLJDaLEzPrAWcZeeSgSIzbL+ecokmFKSDDcRske6QIgSMkHedwND1olF8vlKsJUGK3BcdtM8w4Xq7BpSBwsloE=
const PRIVATE_KEY = 'MIIBVAIBADANBgkqhkiG9w0BAQEFAASCAT4wggE6AgEAAkEAmc3CuPiGL/LcIIm7zryCEIbl1SPzBkr75E2VMtxegyZ1lYRD+7TZGAPkvIsBcaMs6Nsy0L78n2qh+lIZMpLH8wIDAQABAkEAk82Mhz0tlv6IVCyIcw/s3f0E+WLmtPFyR9/WtV3Y5aaejUkU60JpX4m5xNR2VaqOLTZAYjW8Wy0aXr3zYIhhQQIhAMfqR9oFdYw1J9SsNc+CrhugAvKTi0+BF6VoL6psWhvbAiEAxPPNTmrkmrXwdm/pQQu3UOQmc2vCZ5tiKpW10CgJi8kCIFGkL6utxw93Ncj4exE/gPLvKcT+1Emnoox+O9kRXss5AiAMtYLJDaLEzPrAWcZeeSgSIzbL+ecokmFKSDDcRske6QIgSMkHedwND1olF8vlKsJUGK3BcdtM8w4Xq7BpSBwsloE='

/**
 * 生成随机 AES 密钥
 * @param {number} length - 密钥长度 (16, 24, 或 32)
 * @returns {string} 随机字符串
 */
export function generateAesKey(length = 16) {
    const chars = 'ABCDEFGHJKMNPQRSTWXYZabcdefhijkmnprstwxyz2345678'
    let key = ''
    for (let i = 0; i < length; i++) {
        key += chars.charAt(Math.floor(Math.random() * chars.length))
    }
    return key
}

/**
 * AES 加密
 * @param {string} data - 要加密的数据
 * @param {string} key - AES 密钥
 * @returns {string} Base64 编码的加密数据
 */
export function encryptByAes(data, key) {
    const encrypted = CryptoJS.AES.encrypt(data, CryptoJS.enc.Utf8.parse(key), {
        mode: CryptoJS.mode.ECB,
        padding: CryptoJS.pad.Pkcs7
    })
    return encrypted.toString()
}

/**
 * AES 解密
 * @param {string} data - Base64 编码的加密数据
 * @param {string} key - AES 密钥
 * @returns {string} 解密后的数据
 */
export function decryptByAes(data, key) {
    const decrypted = CryptoJS.AES.decrypt(data, CryptoJS.enc.Utf8.parse(key), {
        mode: CryptoJS.mode.ECB,
        padding: CryptoJS.pad.Pkcs7
    })
    return decrypted.toString(CryptoJS.enc.Utf8)
}

/**
 * RSA 加密（用于加密 AES 密钥）
 * @param {string} data - 要加密的数据
 * @returns {string} 加密后的数据
 */
export function encryptByRsa(data) {
    const encrypt = new JSEncrypt()
    encrypt.setPublicKey(PUBLIC_KEY)
    return encrypt.encrypt(data)
}

/**
 * RSA 解密（用于解密响应）
 * @param {string} data - 要解密的数据
 * @returns {string} 解密后的数据
 */
export function decryptByRsa(data) {
    const decrypt = new JSEncrypt()
    decrypt.setPrivateKey(PRIVATE_KEY)
    return decrypt.decrypt(data)
}

/**
 * 加密请求数据（完整流程）
 * @param {object} data - 要加密的数据对象
 * @returns {object} { encryptedData, encryptedKey }
 */
export function encryptRequest(data) {
    // 1. 生成随机 AES 密钥
    const aesKey = generateAesKey(16)

    // 2. 将数据转为 JSON 字符串并用 AES 加密
    const jsonStr = JSON.stringify(data)
    const encryptedData = encryptByAes(jsonStr, aesKey)

    // 3. Base64 编码 AES 密钥（后端会先 RSA 解密，再 Base64 解码）
    const base64Key = CryptoJS.enc.Utf8.parse(aesKey).toString(CryptoJS.enc.Base64)

    // 4. 用 RSA 加密 Base64 编码后的 AES 密钥
    const encryptedKey = encryptByRsa(base64Key)

    return {
        encryptedData,
        encryptedKey
    }
}

// 兼容旧接口
export const encryptData = encryptByRsa
export const decryptData = decryptByRsa
