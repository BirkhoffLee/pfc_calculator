var request = require('supertest');
var assert = require('assert');
var pfc = require('../lib/index.js')

describe('GET /', function () {
    it('Launches PFC_Calculator web server', function (done) {
        request(global.pfc_app)
            .get('/')
            .expect('Content-Type', /html/)
            .expect(200, done);
    });
});