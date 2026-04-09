import { describe, it, expect, vi, beforeEach } from 'vitest';
import request from '@/utils/request';
import * as childApi from './child';
import * as taskApi from './task';
import * as rewardApi from './reward';

// Mock request
vi.mock('@/utils/request', () => ({
  default: vi.fn(),
}));

import request from '@/utils/request';
const mockRequest = request as ReturnType<typeof vi.fn>;

describe('Small Steps API Tests', () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  describe('Child API', () => {
    it('should call listChild', async () => {
      const params = { pageNum: 1, pageSize: 10 };
      const mockResponse = { code: 200, data: { list: [], total: 0 } };
      mockRequest.mockResolvedValue(mockResponse);

      const result = await childApi.listChild(params);

      expect(mockRequest).toHaveBeenCalledWith({
        url: '/smallsteps/child/list',
        method: 'get',
        params: params
      });
      expect(result).toEqual(mockResponse);
    });

    it('should call getChild', async () => {
      const childId = 1;
      const mockResponse = { code: 200, data: { childId, childName: 'Test Child' } };
      mockRequest.mockResolvedValue(mockResponse);

      const result = await childApi.getChild(childId);

      expect(mockRequest).toHaveBeenCalledWith({
        url: `/smallsteps/child/${childId}`,
        method: 'get'
      });
      expect(result).toEqual(mockResponse);
    });

    it('should call addChild', async () => {
      const childData = { childName: 'Test Child', age: 8 };
      const mockResponse = { code: 200, msg: 'success' };
      mockRequest.mockResolvedValue(mockResponse);

      const result = await childApi.addChild(childData);

      expect(mockRequest).toHaveBeenCalledWith({
        url: '/smallsteps/child',
        method: 'post',
        data: childData
      });
      expect(result).toEqual(mockResponse);
    });

    it('should call updateChild', async () => {
      const childData = { childId: 1, childName: 'Updated Child' };
      const mockResponse = { code: 200, msg: 'success' };
      mockRequest.mockResolvedValue(mockResponse);

      const result = await childApi.updateChild(childData);

      expect(mockRequest).toHaveBeenCalledWith({
        url: '/smallsteps/child',
        method: 'put',
        data: childData
      });
      expect(result).toEqual(mockResponse);
    });

    it('should call delChild', async () => {
      const childId = 1;
      const mockResponse = { code: 200, msg: 'success' };
      mockRequest.mockResolvedValue(mockResponse);

      const result = await childApi.delChild(childId);

      expect(mockRequest).toHaveBeenCalledWith({
        url: `/smallsteps/child/${childId}`,
        method: 'delete'
      });
      expect(result).toEqual(mockResponse);
    });
  });

  describe('Task API', () => {
    it('should call listTask', async () => {
      const params = { pageNum: 1, pageSize: 10 };
      const mockResponse = { code: 200, data: { list: [], total: 0 } };
      mockRequest.mockResolvedValue(mockResponse);

      const result = await taskApi.listTask(params);

      expect(mockRequest).toHaveBeenCalledWith({
        url: '/smallsteps/task/list',
        method: 'get',
        params: params
      });
      expect(result).toEqual(mockResponse);
    });

    it('should call addTask', async () => {
      const taskData = { taskName: 'Test Task', description: 'Test Description' };
      const mockResponse = { code: 200, msg: 'success' };
      mockRequest.mockResolvedValue(mockResponse);

      const result = await taskApi.addTask(taskData);

      expect(mockRequest).toHaveBeenCalledWith({
        url: '/smallsteps/task',
        method: 'post',
        data: taskData
      });
      expect(result).toEqual(mockResponse);
    });
  });

  describe('Reward API', () => {
    it('should call listReward', async () => {
      const params = { pageNum: 1, pageSize: 10 };
      const mockResponse = { code: 200, data: { list: [], total: 0 } };
      mockRequest.mockResolvedValue(mockResponse);

      const result = await rewardApi.listReward(params);

      expect(mockRequest).toHaveBeenCalledWith({
        url: '/smallsteps/reward/list',
        method: 'get',
        params: params
      });
      expect(result).toEqual(mockResponse);
    });

    it('should call addReward', async () => {
      const rewardData = { rewardName: 'Test Reward', points: 10 };
      const mockResponse = { code: 200, msg: 'success' };
      mockRequest.mockResolvedValue(mockResponse);

      const result = await rewardApi.addReward(rewardData);

      expect(mockRequest).toHaveBeenCalledWith({
        url: '/smallsteps/reward',
        method: 'post',
        data: rewardData
      });
      expect(result).toEqual(mockResponse);
    });
  });
});
