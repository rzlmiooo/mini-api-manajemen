<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        \App\Models\User::create(['name' => 'Admin User', 'email' => 'admin@example.com', 'password' => \Illuminate\Support\Facades\Hash::make('password'), 'role' => 'admin']);
        \App\Models\User::create(['name' => 'Manager User', 'email' => 'manager@example.com', 'password' => \Illuminate\Support\Facades\Hash::make('password'), 'role' => 'manager']);
        \App\Models\User::create(['name' => 'Developer 1', 'email' => 'dev1@example.com', 'password' => \Illuminate\Support\Facades\Hash::make('password'), 'role' => 'developer']);
        \App\Models\User::create(['name' => 'Developer 2', 'email' => 'dev2@example.com', 'password' => \Illuminate\Support\Facades\Hash::make('password'), 'role' => 'developer']);
    }
}
