<?php

namespace App\Http\Controllers;

use App\Models\Deployment;
use Illuminate\Http\Request;

class DeploymentController extends Controller
{
    public function index()
    {
        return response()->json([
            'success' => true,
            'message' => 'Berhasil mengambil data',
            'data' => Deployment::with(['project', 'server'])->get()
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'project_id' => 'required|exists:projects,id',
            'server_id' => 'required|exists:servers,id',
            'deploy_date' => 'required|date',
            'status' => 'nullable|in:success,failed,pending'
        ]);

        $deployment = Deployment::create($validated);

        return response()->json([
            'success' => true,
            'message' => 'Deployment berhasil dibuat',
            'data' => $deployment
        ], 201);
    }

    public function show(Deployment $deployment)
    {
        $deployment->load(['project', 'server']);
        return response()->json([
            'success' => true,
            'message' => 'Berhasil mengambil data',
            'data' => $deployment
        ]);
    }

    public function update(Request $request, Deployment $deployment)
    {
        $validated = $request->validate([
            'project_id' => 'sometimes|required|exists:projects,id',
            'server_id' => 'sometimes|required|exists:servers,id',
            'deploy_date' => 'sometimes|required|date',
            'status' => 'sometimes|required|in:success,failed,pending'
        ]);

        $deployment->update($validated);

        return response()->json([
            'success' => true,
            'message' => 'Deployment berhasil diupdate',
            'data' => $deployment
        ]);
    }

    public function destroy(Deployment $deployment)
    {
        $deployment->delete();

        return response()->json([
            'success' => true,
            'message' => 'Deployment berhasil dihapus',
            'data' => null
        ]);
    }
}
