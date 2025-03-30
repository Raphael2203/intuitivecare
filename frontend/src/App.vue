<template>
    <div id="app">
      <h1>Bem-vindo a busca de arquivos</h1>
      <form @submit.prevent="fetchData">
        <label for="query">Busque aqui:</label>
        <input type="text" v-model="query" id="query" />
        <button type="submit">Buscar</button>
      </form>
      <div v-if="response">
        <h2>Resultado de busca:</h2>
        <pre>{{ JSON.stringify(response, null, 2) }}</pre>
      </div>
    </div>
  </template>

<script>
export default {
  data () {
    return {
      query: '',
      response: null
    }
  },
  methods: {
    async fetchData () {
      try {
        const res = await fetch(`http://localhost:5000/buscar?termo=${this.query}`)
        if (!res.ok) {
          throw new Error(`Erro do Servidor: ${res.status} - ${res.statusText}`)
        }
        const data = await res.json()
        this.response = data
      } catch (error) {
        console.error('Erro ao conectar ao servidor:', error)
        this.response = { error: 'Não foi possível conectar ao servidor. Tente novamente mais tarde.' }
      }
    }
  }
}
</script>

  <style>
  #app {
    font-family: Arial, sans-serif;
    text-align: center;
    margin: 2rem;
  }

  button {
    margin-top: 1rem;
    padding: 0.5rem 1rem;
    font-size: 1rem;
    cursor: pointer;
  }

  input {
    margin: 0.5rem;
    padding: 0.5rem;
    font-size: 1rem;
  }

  pre {
    text-align: left;
    background: #f4f4f4;
    padding: 1rem;
    border-radius: 5px;
    display: inline-block;
  }
  </style>
