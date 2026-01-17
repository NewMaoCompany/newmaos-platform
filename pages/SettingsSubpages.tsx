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

import { authApi } from '../src/services/api';
import { supabase } from '../src/services/supabaseClient';
import { useToast } from '../components/Toast';

export const ProfileSettings = () => {
  const { user, updateUser } = useApp();
  const { showToast } = useToast();
  const [name, setName] = useState(user.name);
  const [email, setEmail] = useState(user.email);
  const [isSaving, setIsSaving] = useState(false);

  // Verification State
  const [showVerifyModal, setShowVerifyModal] = useState(false);
  const [pendingEmail, setPendingEmail] = useState('');
  const [verifyCode, setVerifyCode] = useState(['', '', '', '', '', '']);
  const [isVerifying, setIsVerifying] = useState(false);

  const handleSave = async () => {
    setIsSaving(true);
    let hasUpdates = false;

    try {
      // 1. Handle Name Change
      if (name !== user.name) {
        // Update Supabase Auth Metadata
        const { error } = await supabase.auth.updateUser({
          data: { name: name }
        });
        if (error) throw error;

        // Update Local State (triggers avatar refresh in AppContext)
        updateUser({ name });
        hasUpdates = true;
      }

      // 2. Handle Email Change
      if (email !== user.email) {
        // Trigger Verification START - Checks if email is taken first
        setPendingEmail(email);
        // Send code to NEW email (will throw 400 if taken)
        const res = await authApi.initiateChangeEmail(email);
        setShowVerifyModal(true);
        // We wait for verification to complete before updating local state/showing success for email
        setIsSaving(false);
        return;
      }

      if (hasUpdates) {
        showToast('Profile updated successfully', 'success');
      }
    } catch (error: any) {
      console.error('Update error:', error);
      showToast(error.message || 'Failed to update profile', 'error');
    } finally {
      setIsSaving(false);
    }
  };

  const handleCodeChange = (index: number, value: string) => {
    if (value.length > 1) return;
    const newCode = [...verifyCode];
    newCode[index] = value;
    setVerifyCode(newCode);

    // Auto-focus next
    if (value && index < 5) {
      document.getElementById(`verify-input-${index + 1}`)?.focus();
    }
  };

  const handleVerify = async () => {
    const code = verifyCode.join('');
    if (code.length !== 6) {
      showToast('Please enter the complete 6-digit code', 'error');
      return;
    }

    setIsVerifying(true);
    try {
      const res = await authApi.verifyChangeEmail(pendingEmail, code, user.id);
      if (res.success) {
        updateUser({ email: pendingEmail });
        setShowVerifyModal(false);
        setVerifyCode(['', '', '', '', '', '']);
        showToast('Email verified and updated successfully', 'success');
      }
    } catch (error: any) {
      showToast(error.message || 'Verification failed', 'error');
    } finally {
      setIsVerifying(false);
    }
  };

  return (
    <SubpageLayout title="Edit Profile">
      <div className="flex flex-col gap-6 relative">
        <div className="flex justify-center mb-4">
          <div className="relative group cursor-pointer">
            <div className="w-24 h-24 rounded-full bg-cover bg-center ring-4 ring-gray-100 dark:ring-gray-800 transition-all duration-300" style={{ backgroundImage: `url(${user.avatarUrl})` }}></div>
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
            className="w-full p-3 rounded-xl border border-gray-200 dark:border-gray-700 bg-transparent outline-none focus:ring-2 focus:ring-primary/50 transition-all"
          />
        </div>
        <div className="flex flex-col gap-1.5">
          <label className="text-sm font-bold text-gray-700 dark:text-gray-300">Email Address</label>
          <input
            type="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            className="w-full p-3 rounded-xl border border-gray-200 dark:border-gray-700 bg-transparent outline-none focus:ring-2 focus:ring-primary/50 transition-all"
          />
        </div>
        <button
          onClick={handleSave}
          disabled={isSaving || (name === user.name && email === user.email)}
          className="mt-4 w-full py-3.5 bg-primary rounded-xl font-bold text-text-main shadow-sm hover:brightness-105 active:scale-95 transition-all flex items-center justify-center gap-2 disabled:opacity-50 disabled:cursor-not-allowed"
        >
          {isSaving ? <span className="material-symbols-outlined animate-spin text-sm">progress_activity</span> : 'Save Changes'}
        </button>

        {/* Verification Modal */}
        {showVerifyModal && (
          <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/60 backdrop-blur-sm animate-fade-in">
            <div className="bg-surface-light dark:bg-surface-dark w-full max-w-sm rounded-3xl p-6 shadow-2xl border border-white/20 relative animate-fade-in-up">
              <button
                onClick={() => setShowVerifyModal(false)}
                className="absolute top-4 right-4 p-1 text-gray-400 hover:text-text-main dark:hover:text-white transition-colors"
              >
                <span className="material-symbols-outlined">close</span>
              </button>

              <div className="text-center mb-6">
                <div className="w-12 h-12 bg-primary rounded-xl flex items-center justify-center text-text-main mx-auto mb-4 shadow-glow">
                  <span className="material-symbols-outlined">mail</span>
                </div>
                <h3 className="text-xl font-black text-text-main dark:text-white">Verify New Email</h3>
                <p className="text-sm text-gray-500 mt-2">
                  Enter the code sent to <br /><span className="font-bold text-text-main dark:text-white">{pendingEmail}</span>
                </p>
              </div>

              <div className="flex justify-between gap-2 mb-6">
                {verifyCode.map((digit, idx) => (
                  <input
                    key={idx}
                    id={`verify-input-${idx}`}
                    type="text"
                    maxLength={1}
                    value={digit}
                    onChange={(e) => handleCodeChange(idx, e.target.value)}
                    className="w-10 h-10 sm:w-12 sm:h-12 rounded-lg border-2 border-gray-200 dark:border-gray-700 bg-transparent text-center text-lg font-bold outline-none focus:border-primary focus:ring-4 focus:ring-primary/20 transition-all"
                  />
                ))}
              </div>

              <button
                onClick={handleVerify}
                disabled={isVerifying}
                className="w-full py-3 bg-primary rounded-xl font-bold text-text-main shadow-md hover:brightness-105 active:scale-95 transition-all flex items-center justify-center gap-2"
              >
                {isVerifying ? <span className="material-symbols-outlined animate-spin">progress_activity</span> : 'Verify & Update'}
              </button>
            </div>
          </div>
        )}
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