<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class ServerSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        \App\Models\Server::create(['name' => 'Web Server 1', 'ip_address' => '192.168.1.10', 'os' => 'Ubuntu 22.04', 'is_active' => true]);
        \App\Models\Server::create(['name' => 'Database Server', 'ip_address' => '192.168.1.20', 'os' => 'CentOS 8', 'is_active' => true]);
    }
}
