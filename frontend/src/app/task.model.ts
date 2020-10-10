export interface Task {
  id: number;
  description: string;
  done: boolean;
  filter: string;
  created_at?: string;
  updated_at?: string;
}
