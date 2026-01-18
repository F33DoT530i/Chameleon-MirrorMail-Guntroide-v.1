import { AuthProvider } from './context/AuthContext';

function App() {
  return (
    <AuthProvider>
      <div className="min-h-screen bg-gray-100">
        <header className="bg-blue-600 text-white p-4 shadow-md">
          <div className="container mx-auto">
            <h1 className="text-2xl font-bold">Chameleon MirrorMail</h1>
            <p className="text-sm">Personal Private Shadow Email Service</p>
          </div>
        </header>
        <main className="container mx-auto p-6">
          <div className="bg-white rounded-lg shadow-md p-6">
            <h2 className="text-xl font-semibold mb-4">Welcome to Chameleon MirrorMail</h2>
            <p className="text-gray-700">
              This is a full-stack application built with React, Express, and PostgreSQL.
            </p>
          </div>
        </main>
      </div>
    </AuthProvider>
  );
}

export default App;
