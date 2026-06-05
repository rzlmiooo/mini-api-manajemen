<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\ProjectController;
use App\Http\Controllers\TaskController;
use App\Http\Controllers\ServerController;
use App\Http\Controllers\DeploymentController;

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);

    // Token (Semua)
    Route::get('/projects', [ProjectController::class, 'index']);
    Route::get('/tasks', [TaskController::class, 'index']);
    Route::put('/tasks/{id}/status', [TaskController::class, 'updateStatus']);

    // Manager & Admin (role.manager)
    Route::middleware('role.manager')->group(function () {
        Route::post('/projects', [ProjectController::class, 'store']);
        Route::put('/projects/{project}', [ProjectController::class, 'update']);
        Route::delete('/projects/{project}', [ProjectController::class, 'destroy']);
        
        Route::post('/tasks', [TaskController::class, 'store']);
        Route::put('/tasks/{task}', [TaskController::class, 'update']);
        Route::delete('/tasks/{task}', [TaskController::class, 'destroy']);
    });

    // Admin Only (role.admin)
    Route::middleware('role.admin')->group(function () {
        Route::apiResource('servers', ServerController::class);
        Route::apiResource('deployments', DeploymentController::class);
    });
});
