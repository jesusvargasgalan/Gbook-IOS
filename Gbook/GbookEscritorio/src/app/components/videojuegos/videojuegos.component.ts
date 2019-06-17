import { Component, OnInit } from '@angular/core';
import { FirestoreService } from '../../services/firestore.service';
import { VideojuegoInterface } from '../../models/VideojuegoInterface';
import * as Chart from 'chart.js';

@Component({
    selector: 'app-videojuegos',
    templateUrl: './videojuegos.component.html',
    styleUrls: ['./videojuegos.component.css']
})
export class VideojuegosComponent implements OnInit {

    constructor(private FirestoreService: FirestoreService) { }

    arrVideogames: VideojuegoInterface[]

    //Array que almacena los titulos
    videogames = [];
    //Array que almacena los emails
    emails = [];
    //Array que almacena likes
    likes = [];
    //Array que almacena el estado del juego "Compra" o "Opinion"
    opcion = [];


    title = 'Gbook';

    //Declaro las variables pertenecientes a las graficas
    LineChart
    LineChart2
    LineChart3
    LineChart4
    LineChart5

    i;

    //Suman las veces que aparece el juego en la base de datos
    countGame1 = 0
    countGame2 = 0
    countGame3 = 0
    countGame4 = 0
    //Suman las fotos subidas por el usuario

    countPhoto = 0;
    countPhoto2 = 0;
    countPhoto3 = 0;

    //Suman el total de compras y opiniones que hay

    countBuy = 0;
    countOpinion = 0;

    //Suman el total de compras de cada juego

    countFifa = 0;
    countGow = 0;
    countMArio = 0;
    countStarWars = 0;

    ngOnInit() {
        this.FirestoreService.getVideogames
        this.FirestoreService.getVideogames().subscribe(videogames => {
            console.log(videogames)
            this.arrVideogames = videogames;


            //Recorre todos los titulos de la base de datos
            for (this.i = 0; this.i < this.arrVideogames.length; this.i++) {
                this.videogames.push(this.arrVideogames[this.i].Nombre);
                console.log(this.videogames)
                if (this.arrVideogames[this.i].Nombre == "God of War") {
                    this.countGame1++
                }
                if (this.arrVideogames[this.i].Nombre == "FIFA") {
                    this.countGame2++
                }
                if (this.arrVideogames[this.i].Nombre == "Mario") {
                    this.countGame3++
                }
                if (this.arrVideogames[this.i].Nombre == "Star Wars") {
                    this.countGame4++
                }



            }
            this.creartabla()

            //Recorre la tabla Post entera en busca de fotos almacenadas por los usuarios
            for (this.i = 0; this.i < this.arrVideogames.length; this.i++) {
                this.videogames.push(this.arrVideogames[this.i].FotoVideojuego);
                this.emails.push(this.arrVideogames[this.i].Email);
                console.log(this.videogames)
                if (this.arrVideogames[this.i].Email == "prueba@gmail.com") {
                    if (this.arrVideogames[this.i].FotoVideojuego != "")
                        this.countPhoto++
                }
                if (this.arrVideogames[this.i].Email == "prueba2@gmail.com") {
                    if (this.arrVideogames[this.i].FotoVideojuego != "")
                        this.countPhoto2++
                }
                if (this.arrVideogames[this.i].Email == "jesus@gmail.com") {
                    if (this.arrVideogames[this.i].FotoVideojuego != "")
                        this.countPhoto3++
                }
                /*if(this.arrVideogames[this.i].Email == "prueba3@gmail.com"){
                   if(this.arrVideogames[this.i].FotoVideojuego != "")
                 this.countPhoto++
               }*/


            }
            this.creartabla2()

            //Recorro los videojuegos para ver cuantos likes tiene cada uno

            for (this.i = 0; this.i < this.arrVideogames.length; this.i++) {
                this.videogames.push(this.arrVideogames[this.i].FotoVideojuego);
                this.likes.push(this.arrVideogames[this.i].Likes);
                console.log(this.videogames)


            }

            this.creartabla3()

            for (this.i = 0; this.i < this.arrVideogames.length; this.i++) {
                this.videogames.push(this.arrVideogames[this.i].FotoVideojuego);
                this.opcion.push(this.arrVideogames[this.i].Check);
                if (this.arrVideogames[this.i].Check == "Compra"){
                    this.countBuy++;
                }else{
                    this.countOpinion++;
                }
                console.log(this.videogames)
            }
            this.creartabla4()

            for (this.i = 0; this.i < this.arrVideogames.length; this.i++) {
                this.videogames.push(this.arrVideogames[this.i].FotoVideojuego);
                this.opcion.push(this.arrVideogames[this.i].Check);
                if ( this.arrVideogames[this.i].Nombre == "FIFA" && this.arrVideogames[this.i].Check == "Compra") {
                    this.countFifa++;
                } 
                if (this.arrVideogames[this.i].Nombre == "God of War" && this.arrVideogames[this.i].Check == "Compra") {
                    this.countGow++;
                }
                if (this.arrVideogames[this.i].Nombre == "Mario" && this.arrVideogames[this.i].Check == "Compra") {
                    this.countMArio++;
                }
                if (this.arrVideogames[this.i].Nombre == "Star Wars" && this.arrVideogames[this.i].Check == "Compra") {
                    this.countStarWars++;
                }    
                
                console.log(this.videogames)
            }
            this.creartabla5()
        });

    }
    creartabla() {
        this.LineChart = new Chart('lineChart', {
            type: 'bar',
            data: {

                labels: ["God of War","FIFA", "Mario", "Star Wars"],
                datasets: [{
                    label: 'Veces que aparecen los juegos posteados',
                    data: [this.countGame1, this.countGame2, this.countGame3],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true
                        }
                    }]
                }
            }

        });
    }
    creartabla2() {
        this.LineChart2 = new Chart('lineChart2', {
            type: 'bar',
            data: {

                labels: ["prueba@gmail.com", "prueba2@gmail.com", "jesus@gmail.com"],
                datasets: [{
                    label: 'Fotos subidas por cada usuario',
                    data: [this.countPhoto, this.countPhoto2, this.countPhoto3],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true
                        }
                    }]
                }
            }

        });
    }
    creartabla3() {
        this.LineChart3 = new Chart('lineChart3', {
            type: 'bar',
            data: {

                labels: [this.videogames[0], this.videogames[1], this.videogames[2], this.videogames[3], this.videogames[4], this.videogames[5]],
                datasets: [{
                    label: 'Likes que tiene cada titulo posteado',
                    data: [this.likes[0], this.likes[1], this.likes[2], this.likes[3], this.likes[4], this.likes[5] ],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true
                        }
                    }]
                }
            }

        });
    }
    creartabla4() {
        this.LineChart4 = new Chart('lineChart4', {
            type: 'bar',
            data: {

                labels: ["Compra","Opinion"],
                datasets: [{
                    label: 'Número total de posts Compra/Opinión',
                    data: [this.countBuy, this.countOpinion],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true
                        }
                    }]
                }
            }

        });
    }
    creartabla5() {
        this.LineChart5 = new Chart('lineChart5', {
            type: 'bar',
            data: {

                labels: ["FIFA", "God of War" , "Mario", "Star Wars"],
                datasets: [{
                    label: 'Videojuego con mas compras(el más deseado por los usuarios)',
                    data: [this.countFifa, this.countGow, this.countMArio, this.countStarWars],
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true
                        }
                    }]
                }
            }

        });
    }
}
