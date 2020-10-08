<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Task;
use Exception;

class TaskController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $tasks = $this->getTasks("all");
        return response()->json(['message' => '','data'=>$tasks], 200);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $data = $request->all();

        try{

            $task = Task::create($data);

            if ($task){
                $tasks = $this->getTasks($data['filtro']);

                return response()->json(['message' => 'Nova tarefa adicionada com sucesso','data'=>$tasks], 200);
            }

        }catch (Exception $e) {
            return response()->json(['message' =>"Erro ao salvar os dados: {$e->getMessage()}",'data'=>[]], 400);
        }
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $data = $request->all();

        try{

            $task = Task::find($id);

            if ($task) {
                $task->update($data);

                $tasks = $this->getTasks($data['filtro']);

                return response()->json(['message' => 'Tarefa atualizada','data'=>$tasks], 200);
            }

            return response()->json(['message' =>"Tarefa não encontrada",'data'=>[]], 400);

        }catch (Exception $e) {
            return response()->json(['message' =>"Erro ao atualizar os dados: {$e->getMessage()}",'data'=>[]], 400);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        try{

            $task = Task::find($id);

            if ($task) {
                $task->delete();
                return response()->json(['message' => 'Tarefa excluída com sucesso','data'=>[]], 200);
            }

            return response()->json(['message' =>"Tarefa não encontrada",'data'=>[]], 400);

        }catch (Exception $e) {
            return response()->json(['message' =>"Erro ao excluír a tarefa: {$e->getMessage()}",'data'=>[]], 400);
        }
    }

    public function getListTask($filtro)
    {
           $tasks = $this->getTasks($filtro);
           return response()->json(['message' => '','data' => $tasks], 200);
    }

    public function getTasks($filtro)
    {
        try{

            switch($filtro){
                 case 'done':
                     $tasks = Task::where('done', true)->orderBy('id','DESC')->get();
                 break;
                 case 'unrealized':
                     $tasks = Task::where('done', false)->orderBy('id','DESC')->get();
                 break;
                 default:
                     $tasks = Task::all()->sortByDesc('id')->toArray();
            }
 
         }catch (Exception $e) {
             return response()->json(['message' => "Erro ao buscar a lista de tarefa: {$e->getMessage()}",'data'=>[]], 400);
         }
    
        return $tasks ? $tasks : [];
    }

}
