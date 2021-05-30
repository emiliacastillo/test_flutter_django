# from django.shortcuts import render
# from django.views.generic import ListView, DetailView
# from django.views.generic.edit import CreateView, UpdateView, DeleteView
#
# from django.urls import reverse
#
# # Habilitamos el uso de mensajes en Django
# from django.contrib import messages
#
# # Habilitamos los mensajes para class-based views
# from django.contrib.messages.views import SuccessMessageMixin
#
# # Habilitamos los formularios en Django
# from django import forms
#
# from .models import Task
# # Create your views here.

from rest_framework import viewsets
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import Task
from .serializable import TasksSerializer
from django.http import FileResponse, HttpResponse, JsonResponse

@api_view(['GET'])
def validserver(request):
    if request.method == 'GET':
        return Response(status.HTTP_200_OK)

@api_view(['GET', 'POST'])
def insert_task(request):
    if request.method == 'POST':
        serializer = TasksSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(status.HTTP_200_OK)


@api_view(['GET'])
def tasks(request):
    """
    List all code Tasks, or create a new Task.
    """
    if request.method == 'GET':
        tasks = Task.objects.all()
        serializer = TasksSerializer(tasks, many=True)
        return Response(serializer.data)

@api_view(['POST'])
def update_task(request):
    if request.method == "POST":  # Example of updating an object via manual serialization
        personnel = Task.objects.get(id=request.data['id'])
        x = TasksSerializer(personnel, data={"title": request.data['title']})
        if x.is_valid():
            x.update(personnel, x.validated_data)
        else:
            print
            x.errors
        return Response(x.data, status=status.HTTP_200_OK)

@api_view(['GET'])
def get_task(request,id):
    if request.method == 'GET':
        task_id = id
        tasks = Task.objects.filter(id=task_id)
        if tasks:
            tasks = Task.objects.get(id=task_id)
            serializer = TasksSerializer(tasks, many=False)
            return JsonResponse(serializer.data)
        return Response(status.HTTP_404_NOT_FOUND)


@api_view(['DELETE'])
def delete_task(request,id):
    if request.method == 'DELETE':
        task_id = id
        tasks = Task.objects.filter(id=task_id)
        if tasks:
            Task.objects.get(id=task_id).delete()
            return Response(status.HTTP_200_OK)
        return Response(status.HTTP_404_NOT_FOUND)