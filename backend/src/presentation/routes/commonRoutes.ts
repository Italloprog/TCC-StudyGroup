import { Application } from "express";

export abstract class CommonRoutes{
    nome: string;
    app: Application;
    rota: string;

    constructor(nome: string,app: Application,rota: string){
        this.nome = nome;
        this.app = app;
        this.rota = rota;
        this.configureRoutes();
    };

    abstract configureRoutes(): Application
}