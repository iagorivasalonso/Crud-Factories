import express from "express";
import { login, logout, restore } from "../controllers/sessionController.js";
import {requestPasswordReset, verifyPasswordReset,resetPassword} from "../controllers/passwordResetController.js";

const router = express.Router();

router.post("/login", login);
router.post("/logout", logout);
router.post("/restore", restore);

router.post("/password/request", requestPasswordReset);
router.post("/password/verify", verifyPasswordReset);
router.post("/password/reset", resetPassword);

export default router;