import express from "express";
import { login, logout,restore } from "../controllers/sessionController.js";

const router = express.Router();

router.post("/login", login);
router.post("/logout", logout);
router.post("/restore", restore);

export default router;