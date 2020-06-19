const jwt = require('jsonwebtoken');
const config = require('../config')

async function verifyToken (req,res,next){
        const token = req.headers['x-access-token']
        
}