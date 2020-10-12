<?php

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
 */


Route::get('/', function () {
    echo "ESIG-TESTE API";
});

Route::get('/task/{filtro}', 'TaskController@getListTask');

Route::resource('/task', 'TaskController');

Route::delete('/task-done', 'TaskController@destroyTaskDone');

