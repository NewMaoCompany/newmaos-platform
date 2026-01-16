import React, { useState } from 'react';
import { useApp } from '../AppContext';
import { useNavigate } from 'react-router-dom';
import { Navbar } from '../components/Navbar';

const SubpageLayout = ({ title, children }: { title: string, children: React.ReactNode }) => {
  const navigate = useNavigate();
  return (
    <div className="min-h-screen bg-background-light dark:bg-background-dark text-text-main dark:text-gray-100 flex flex-col">
      <Navbar />
      <div className="flex-grow flex justify-center p-6">
        <div className="w-full max-w-2xl flex flex-col gap-6 mt-6 animate-fade-in">
            <button 
            onClick={() => navigate('/settings')} 
            className="flex items-center gap-2 text-sm font-bold text-gray-500 hover:text-text-main dark:text-gray-400 dark:hover:text-white transition-colors w-fit"
            >
            <span className="material-symbols-outlined">arrow_back</span>
            Back to Settings
            </button>
            <h1 className="text-3xl font-black">{title}</h1>
            <div className="bg-white dark:bg-surface-dark rounded-2xl border border-gray-200 dark:border-gray-800 p-6 shadow-sm">
            {children}
            </div>
        </div>
      </div>
    </div>
  );
};

export const ProfileSettings = () => {
  const { user, updateUser } = useApp();
  const [name, setName] = useState(user.name);
  const [email, setEmail] = useState(user.email);
  const [isSaved, setIsSaved] = useState(false);

  const handleSave = () => {
    updateUser({ name, email });
    setIsSaved(true);
    setTimeout(() => setIsSaved(false), 2000);
  };

  return (
    <SubpageLayout title="Edit Profile">
      <div className="flex flex-col gap-6">
        <div className="flex justify-center mb-4">
           <div className="relative group cursor-pointer">
              <div className="w-24 h-24 rounded-full bg-cover bg-center ring-4 ring-gray-100 dark:ring-gray-800" style={{ backgroundImage: `url(${user.avatarUrl})` }}></div>
              <div className="absolute inset-0 bg-black/40 rounded-full flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity">
                <span className="material-symbols-outlined text-white">edit</span>
              </div>
           </div>
        </div>
        <div className="flex flex-col gap-1.5">
          <label className="text-sm font-bold text-gray-700 dark:text-gray-300">Display Name</label>
          <input 
            type="text" 
            value={name} 
            onChange={(e) => setName(e.target.value)}
            className="w-full p-3 rounded-xl border border-gray-200 dark:border-gray-700 bg-transparent outline-none focus:ring-2 focus:ring-primary/50"
          />
        </div>
        <div className="flex flex-col gap-1.5">
          <label className="text-sm font-bold text-gray-700 dark:text-gray-300">Email Address</label>
          <input 
            type="email" 
            value={email} 
            onChange={(e) => setEmail(e.target.value)}
            className="w-full p-3 rounded-xl border border-gray-200 dark:border-gray-700 bg-transparent outline-none focus:ring-2 focus:ring-primary/50"
          />
        </div>
        <button 
          onClick={handleSave}
          className="mt-4 w-full py-3.5 bg-primary rounded-xl font-bold text-text-main shadow-sm hover:brightness-105 active:scale-95 transition-all flex items-center justify-center gap-2"
        >
          {isSaved ? <span className="material-symbols-outlined">check</span> : null}
          {isSaved ? 'Saved Successfully' : 'Save Changes'}
        </button>
      </div>
    </SubpageLayout>
  );
};

export const SecuritySettings = () => {
  const [password, setPassword] = useState('');
  const [newPassword, setNewPassword] = useState('');
  const [isUpdating, setIsUpdating] = useState(false);

  const handleUpdate = () => {
      setIsUpdating(true);
      setTimeout(() => {
          setIsUpdating(false);
          setPassword('');
          setNewPassword('');
          alert("Password updated successfully.");
      }, 1000);
  }

  return (
    <SubpageLayout title="Password & Security">
      <div className="flex flex-col gap-6">
        <div className="flex flex-col gap-1.5">
          <label className="text-sm font-bold text-gray-700 dark:text-gray-300">Current Password</label>
          <input 
            type="password" 
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            placeholder="••••••••" 
            className="w-full p-3 rounded-xl border border-gray-200 dark:border-gray-700 bg-transparent outline-none focus:ring-2 focus:ring-primary/50" 
          />
        </div>
        <div className="flex flex-col gap-1.5">
          <label className="text-sm font-bold text-gray-700 dark:text-gray-300">New Password</label>
          <input 
            type="password" 
            value={newPassword}
            onChange={(e) => setNewPassword(e.target.value)}
            placeholder="Enter new password" 
            className="w-full p-3 rounded-xl border border-gray-200 dark:border-gray-700 bg-transparent outline-none focus:ring-2 focus:ring-primary/50" 
          />
        </div>
        <button 
            onClick={handleUpdate}
            disabled={!password || !newPassword || isUpdating}
            className="mt-4 w-full py-3.5 bg-black dark:bg-white text-white dark:text-black rounded-xl font-bold shadow-sm hover:opacity-90 active:scale-95 transition-all disabled:opacity-50 flex justify-center items-center gap-2"
        >
          {isUpdating ? <span className="material-symbols-outlined animate-spin text-sm">progress_activity</span> : 'Update Password'}
        </button>
      </div>
    </SubpageLayout>
  );
};

export const BillingSettings = () => {
  const [isUpgrading, setIsUpgrading] = useState(false);
  const [plan, setPlan] = useState<'Basic' | 'Pro'>('Basic');

  const handleUpgrade = () => {
      setIsUpgrading(true);
      setTimeout(() => {
          setIsUpgrading(false);
          setPlan('Pro');
          alert("Successfully upgraded to Pro Plan! You now have access to unlimited AI practice.");
      }, 1500);
  };

  const handleAddPayment = () => {
      alert("This would open the payment gateway integration (Stripe/PayPal) in a real deployment.");
  }

  return (
    <SubpageLayout title="Subscription & Billing">
       <div className="flex flex-col gap-6">
        <div className={`p-4 rounded-xl ${plan === 'Pro' ? 'bg-primary/10 border-primary' : 'bg-gray-50 dark:bg-white/5 border-gray-200 dark:border-gray-700'} border flex justify-between items-center`}>
            <div>
                <p className="font-bold text-lg">{plan} Plan</p>
                <p className="text-sm text-gray-500">{plan === 'Basic' ? 'Free forever' : '$9.99 / month'}</p>
            </div>
            <span className={`px-3 py-1 rounded-full text-xs font-bold ${plan === 'Pro' ? 'bg-primary text-black' : 'bg-green-100 text-green-700'}`}>Active</span>
        </div>

        {plan === 'Basic' && (
            <div className="space-y-4">
                <h3 className="font-bold text-sm uppercase text-gray-500">Upgrade Options</h3>
                <div className="p-4 rounded-xl border-2 border-primary/20 hover:border-primary cursor-pointer transition-colors flex justify-between items-center group">
                    <div>
                        <p className="font-bold text-lg group-hover:text-primary transition-colors">Pro Plan</p>
                        <p className="text-sm text-gray-500">$9.99 / month</p>
                    </div>
                    <button 
                        onClick={handleUpgrade}
                        disabled={isUpgrading}
                        className="px-4 py-2 bg-primary rounded-lg font-bold text-sm shadow-sm hover:brightness-105 active:scale-95 transition-all flex items-center gap-2"
                    >
                        {isUpgrading ? <span className="material-symbols-outlined animate-spin text-sm">progress_activity</span> : 'Upgrade'}
                    </button>
                </div>
            </div>
        )}

        <div className="mt-4 pt-4 border-t border-gray-200 dark:border-gray-700">
             <h3 className="font-bold text-sm uppercase text-gray-500 mb-4">Payment Methods</h3>
             <div className="flex flex-col gap-4">
                 <div className="flex items-center gap-3 text-gray-500 text-sm italic">
                    <span className="material-symbols-outlined">credit_card_off</span>
                    No payment methods added.
                 </div>
                 <button 
                    onClick={handleAddPayment}
                    className="text-primary font-bold text-sm hover:underline self-start"
                 >
                    + Add Payment Method
                 </button>
             </div>
        </div>
      </div>
    </SubpageLayout>
  );
};