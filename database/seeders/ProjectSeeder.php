<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class ProjectSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        \App\Models\Project::create(['name' => 'E-Commerce Website', 'description' => 'Build a new modern e-commerce', 'status' => 'ongoing']);
        \App\Models\Project::create(['name' => 'CRM Migration', 'description' => 'Migrate old CRM to Salesforce', 'status' => 'planning']);
    }
}
