import { Request, Response } from "express";

export class commentController{

    constructor(){
    }
    
    public adicionarComentario = async (_req: Request, res: Response) =>{
        res.send('Hello, World!trueform');
    }

    public removerComentario = async (_req: Request, res: Response) =>{
        //recebe req
        //envia para a camada de serviço
        //trata res e envia

        res.send('Hello, World!trueform');
    }
}