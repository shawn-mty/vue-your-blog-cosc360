import jwt from 'jsonwebtoken';
import crypto from 'crypto';
import axios from 'axios';
import { BlogEntry } from '../../models';


export const allBlogEntries = async (req, res) => {
  try {
    const page = req.params.page || 1;
    const limit = 2;
    const blogEntries = await BlogEntry.findAndCountAll({
      order: [['createdAt', 'DESC'], ['firstName', 'ASC']],
      offset: (page - 1) * limit,
      limit,
    });
    return successResponse(req, res, { blogEntries });
  } catch (error) {
    return errorResponse(req, res, error.message);
  }
};

export const addBlogEntry = async (req, res) => {
  try {
    const {
      title, body, isAdmin,
    } = req.body;
    if (process.env.IS_GOOGLE_AUTH_ENABLE === 'true') {
      if (!req.body.code) {
        throw new Error('code must be defined');
      }
      const { code } = req.body;
      const customUrl = `${process.env.GOOGLE_CAPTCHA_URL}?secret=${
        process.env.GOOGLE_CAPTCHA_SECRET_SERVER
      }&response=${code}`;
      const response = await axios({
        method: 'post',
        url: customUrl,
        data: {
          secret: process.env.GOOGLE_CAPTCHA_SECRET_SERVER,
          response: code,
        },
        config: { headers: { 'Content-Type': 'multipart/form-data' } },
      });
      if (!(response && response.data && response.data.success === true)) {
        throw new Error('Google captcha is not valid');
      }
    }

    const blogEntry = await BlogEntry.scope('withSecretColumns').findOne({
      where: { email },
    });
    if (user) {
      throw new Error('User already exists with same email');
    }
    const reqPass = crypto
      .createHash('md5')
      .update(password)
      .digest('hex');
    const payload = {
      email,
      firstName,
      lastName,
      password: reqPass,
      isVerified: false,
      verifyToken: uniqueId(),
    };

    const newUser = await User.create(payload);
    return successResponse(req, res, {});
  } catch (error) {
    return errorResponse(req, res, error.message);
  }
};
