# from django.views.generic import ListView, DetailView
# from django.views.generic.edit import CreateView, UpdateView, DeleteView
# from .models import Task
#
# from django.urls import reverse
#
# from django.contrib import messages
# from django.contrib.messages.views import SuccessMessageMixin
#
# from django import forms
#
#
# class TaskListado(ListView):
#     model = Task
#
#
# class TaskDetalle(DetailView):
#     model = Task
#
#
# class TaskCrear(SuccessMessageMixin, CreateView):
#     model = Task
#     form = Task
#     fields = "__all__"
#     success_message = 'Task Creado Correctamente !'  # Mostramos este Mensaje luego de Crear un Task
#
#     # Redireccionamos a la página principal luego de crear un registro o Task
#     def get_success_url(self):
#         return reverse('leer')  # Redireccionamos a la vista principal 'leer'
#
#
# class TaskActualizar(SuccessMessageMixin, UpdateView):
#     model = Task
#     form = Task
#     fields = "__all__"
#     success_message = 'Task Actualizado Correctamente !'  # Mostramos este Mensaje luego de Editar un Task
#
#     # Redireccionamos a la página principal luego de actualizar un registro o Task
#     def get_success_url(self):
#         return reverse('leer')  # Redireccionamos a la vista principal 'leer'
#
#
# class TaskEliminar(SuccessMessageMixin, DeleteView):
#     model = Task
#     form = Task
#     fields = "__all__"
#
#     # Redireccionamos a la página principal luego de eliminar un registro o Task
#     def get_success_url(self):
#         success_message = 'Task Eliminado Correctamente !'  # Mostramos este Mensaje luego de Editar un Task
#         messages.success(self.request, (success_message))
#         return reverse('leer')


from rest_framework import serializers
from .models import Task

class TasksSerializer(serializers.ModelSerializer):
    def update(self, instance, validated_data):
        setattr(instance, "title", self.validated_data.get('title', instance.title))
        instance.save()
        return instance

    def save(self):
        task = Task(
            title=self.validated_data['title'],
        )
        task.save()
        return task
    class Meta:
        model = Task
        fields = ['id', 'title']
