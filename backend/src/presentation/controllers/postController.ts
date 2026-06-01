import { Request, Response } from "express";

export class postController{

    constructor(){
    }
    
    public criarPostagem = async (_req: Request, res: Response) =>{
        res.send('Hello, World!trueform');
    }

    public removerPostagem = async (_req: Request, res: Response) =>{
        res.send('Hello, World!trueform');
    }
}