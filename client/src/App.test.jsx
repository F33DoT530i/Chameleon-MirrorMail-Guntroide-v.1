import { render, screen } from '@testing-library/react';
import { describe, it, expect } from 'vitest';
import App from './App';

describe('App', () => {
  it('renders the app title', () => {
    render(<App />);
    expect(screen.getByText('Chameleon MirrorMail')).toBeDefined();
  });

  it('renders the app description', () => {
    render(<App />);
    expect(screen.getByText('Personal Private Shadow Email Service')).toBeDefined();
  });

  it('renders the welcome message', () => {
    render(<App />);
    expect(screen.getByText('Welcome to Chameleon MirrorMail')).toBeDefined();
  });
});
