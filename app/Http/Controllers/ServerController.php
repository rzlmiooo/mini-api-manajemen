<?php

namespace App\Http\Controllers;

use App\Models\Server;
use Illuminate\Http\Request;

class ServerController extends Controller
{
    public function index()
    {
        return response()->json([
            'success' => true,
            'message' => 'Berhasil mengambil data',
            'data' => Server::all()
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'ip_address' => 'required|string|ip',
            'os' => 'required|string|max:255',
            'is_active' => 'boolean'
        ]);

        $server = Server::create($validated);

        return response()->json([
            'success' => true,
            'message' => 'Server berhasil dibuat',
            'data' => $server
        ], 201);
    }

    public function show(Server $server)
    {
        return response()->json([
            'success' => true,
            'message' => 'Berhasil mengambil data',
            'data' => $server
        ]);
    }

    public function update(Request $request, Server $server)
    {
        $validated = $request->validate([
            'name' => 'sometimes|required|string|max:255',
            'ip_address' => 'sometimes|required|string|ip',
            'os' => 'sometimes|required|string|max:255',
            'is_active' => 'boolean'
        ]);

        $server->update($validated);

        return response()->json([
            'success' => true,
            'message' => 'Server berhasil diupdate',
            'data' => $server
        ]);
    }

    public function destroy(Server $server)
    {
        $server->delete();

        return response()->json([
            'success' => true,
            'message' => 'Server berhasil dihapus',
            'data' => null
        ]);
    }
}
