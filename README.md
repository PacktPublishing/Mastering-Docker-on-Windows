# Mastering Docker on Windows – Companion Files

This repository contains the companion files for the book **Mastering Docker on Windows**, published by Packt.

The content here is organised by chapter and mirrors the practical examples, Big Labs, standalone files, and command cheat sheets used throughout the book. Nothing in this repository is theoretical. Every file exists to support something you build, run, or debug while working through the chapters.

## Repository Structure

Each chapter has its own folder:

Chapter 1/
Chapter 2/
Chapter 3/
...
Chapter 10/


Inside a chapter folder you may find:

- **Dockerfiles**  
  Example Dockerfiles used in that chapter (Windows and Linux where applicable)

- **Docker Compose files**  
  Local, remote, secrets, health check, volume, and multi-host examples

- **Configuration files**  
  Logging configs, secrets templates, Nginx configs, and supporting artefacts

- **Cheat sheets**  
  Markdown files listing every Docker command used in that chapter with short explanations

- **Big Lab artefacts**  
  Files produced or inspected as part of the ongoing Big Lab exercises

Not every chapter contains every type of file. Chapters only include artefacts that are actually used.

## How to Use This Repository

This repo is designed to be used **alongside the book**, not as a standalone tutorial.

Recommended workflow:

1. Read the chapter in the book  
2. When a file is referenced, open the matching chapter folder here  
3. Copy or adapt the file as instructed in the text  
4. Use the chapter cheat sheet to understand and repeat the commands

If a file exists here, it is because it appears in the book either directly or as a referenced example.

## Windows Focus

All examples are written with **Windows 11**, **Docker Desktop**, and **WSL2** in mind.

Where Linux-based examples appear, they are included explicitly and called out as such. Windows container examples use pinned LTSC base images to match enterprise realities.
