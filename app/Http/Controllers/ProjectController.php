<?php

namespace App\Http\Controllers;

use App\Models\Project;
use Illuminate\Http\Request;

class ProjectController extends Controller
{
    public function index()
    {
        $projects = Project::all();
        return response()->json([
            'success' => true,
            'message' => 'Berhasil mengambil data',
            'data' => $projects
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
            'status' => 'nullable|in:planning,ongoing,completed'
        ]);

        $project = Project::create($validated);

        return response()->json([
            'success' => true,
            'message' => 'Project berhasil dibuat',
            'data' => $project
        ], 201);
    }

    public function update(Request $request, Project $project)
    {
        $validated = $request->validate([
            'name' => 'sometimes|required|string|max:255',
            'description' => 'nullable|string',
            'status' => 'sometimes|required|in:planning,ongoing,completed'
        ]);

        $project->update($validated);

        return response()->json([
            'success' => true,
            'message' => 'Project berhasil diupdate',
            'data' => $project
        ]);
    }

    public function destroy(Project $project)
    {
        // Don't allow deletion if there are tasks without cascade. But we use cascade.
        // I will add a check anyway to be robust if needed, but rule says "Jangan izinkan penghapusan Project jika ada Task di dalamnya tanpa menggunakan Cascade Delete."
        // We are using cascade delete on the DB, so it's fine. If we want to strictly follow the text:
        if ($project->tasks()->count() > 0) {
             return response()->json([
                 'success' => false,
                 'message' => 'Project tidak bisa dihapus karena memiliki task.',
                 'errors' => null
             ], 422);
        }

        $project->delete();

        return response()->json([
            'success' => true,
            'message' => 'Project berhasil dihapus',
            'data' => null
        ]);
    }
}
