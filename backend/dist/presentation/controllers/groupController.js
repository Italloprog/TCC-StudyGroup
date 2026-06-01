"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.groupController = void 0;
class groupController {
    constructor() {
        this.criarGrupo = (_req, res) => __awaiter(this, void 0, void 0, function* () {
            res.send('Hello, World!trueform');
        });
        this.editarGrupo = (_req, res) => __awaiter(this, void 0, void 0, function* () {
            res.send('Hello, World!trueform');
        });
        this.encerrarGrupo = (_req, res) => __awaiter(this, void 0, void 0, function* () {
            res.send('Hello, World!trueform');
        });
        this.entrarGrupo = (_req, res) => __awaiter(this, void 0, void 0, function* () {
            res.send('Hello, World!trueform');
        });
        this.removerUsuario = (_req, res) => __awaiter(this, void 0, void 0, function* () {
            res.send('Hello, World!trueform');
        });
        this.deixarGrupo = (_req, res) => __awaiter(this, void 0, void 0, function* () {
            res.send('Hello, World!trueform');
        });
        this.gerarRanking = (_req, res) => __awaiter(this, void 0, void 0, function* () {
            res.send('Hello, World!trueform');
        });
    }
}
exports.groupController = groupController;
//# sourceMappingURL=groupController.js.map