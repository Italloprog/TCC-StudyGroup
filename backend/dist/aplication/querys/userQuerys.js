"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.userQuerys = void 0;
const userRepository_1 = require("../../persistence/firebase/repositories/userRepository");
class userQuerys {
    constructor() {
        this.userRepo = new userRepository_1.UserRepository();
    }
}
exports.userQuerys = userQuerys;
//# sourceMappingURL=userQuerys.js.map