import { expect } from 'chai';
import request from 'supertest';
import app from '../src/index.js';

describe('Server API', () => {
  describe('GET /health', () => {
    it('should return health status', async () => {
      const res = await request(app).get('/health');

      expect(res.status).to.equal(200);
      expect(res.body).to.have.property('success', true);
      expect(res.body).to.have.property('message', 'Server is running');
      expect(res.body).to.have.property('timestamp');
    });
  });

  describe('POST /api/auth/register', () => {
    it('should return error when missing required fields', async () => {
      const res = await request(app).post('/api/auth/register').send({
        email: 'test@example.com',
      });

      expect(res.status).to.equal(400);
      expect(res.body).to.have.property('success', false);
      expect(res.body).to.have.property('error');
    });
  });

  describe('POST /api/auth/login', () => {
    it('should return error when missing credentials', async () => {
      const res = await request(app).post('/api/auth/login').send({
        email: 'test@example.com',
      });

      expect(res.status).to.equal(400);
      expect(res.body).to.have.property('success', false);
      expect(res.body).to.have.property('error');
    });
  });
});
