<?php

namespace App\Http\Controllers;

use App\Models\Task;
use Illuminate\Http\Request;

class TaskController extends Controller
{
    public function index(Request $request)
    {
        if ($request->user()->isAdmin() || $request->user()->isManager()) {
            $tasks = Task::with(['project', 'user'])->get();
        } else {
            $tasks = Task::with(['project', 'user'])->where('user_id', $request->user()->id)->get();
        }

        return response()->json([
            'success' => true,
            'message' => 'Berhasil mengambil data',
            'data' => $tasks
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'project_id' => 'required|exists:projects,id',
            'user_id' => 'required|exists:users,id',
            'title' => 'required|string|max:255',
            'status' => 'nullable|in:todo,in_progress,done'
        ]);

        $task = Task::create($validated);

        return response()->json([
            'success' => true,
            'message' => 'Task berhasil dibuat',
            'data' => $task
        ], 201);
    }

    public function update(Request $request, Task $task)
    {
        $validated = $request->validate([
            'project_id' => 'sometimes|required|exists:projects,id',
            'user_id' => 'sometimes|required|exists:users,id',
            'title' => 'sometimes|required|string|max:255',
            'status' => 'sometimes|required|in:todo,in_progress,done'
        ]);

        $task->update($validated);

        return response()->json([
            'success' => true,
            'message' => 'Task berhasil diupdate',
            'data' => $task
        ]);
    }

    public function updateStatus(Request $request, $id)
    {
        $task = Task::findOrFail($id);
        
        $validated = $request->validate([
            'status' => 'required|in:todo,in_progress,done'
        ]);

        // Authorization rule: Developer only can update to done. Wait, rule says: "Developer bisa update status task ke 'done'"
        // The middleware already protects against managers/admins for the main CRUD. For this route, everyone is allowed.
        // It's safe to just update.

        $task->update(['status' => $validated['status']]);

        return response()->json([
            'success' => true,
            'message' => 'Status task berhasil diupdate',
            'data' => $task
        ]);
    }

    public function destroy(Task $task)
    {
        $task->delete();

        return response()->json([
            'success' => true,
            'message' => 'Task berhasil dihapus',
            'data' => null
        ]);
    }
}
